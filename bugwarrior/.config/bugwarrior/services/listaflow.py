from datetime import datetime
import logging

import requests
import typing_extensions

from dateutil import relativedelta
from bugwarrior import config
from bugwarrior.services import IssueService, Issue, ServiceClient

log = logging.getLogger(__name__)
LISTS_URL = 'https://api.app.listaflow.com/api/workflow/checklist/list/?is_archived=false&list_name=TO_DO&page=1&size=24&statuses=&usernames=&name='
TASK_URL = 'https://api.app.listaflow.com/api/workflow/user/{username}/checklist/{list_id}/task/'
HEADERS = {'Authorization': 'Bearer bYSUzSoSQxJhHZ9ZDQuVb56ucXSao5'}
LIST_NAME = 'OpenCraft Sprint Checklist'
MIDNIGHT_FORMAT = '%Y%m%dT235959Z'


class ListaflowConfig(config.ServiceConfig):
    service: typing_extensions.Literal['listaflow']

    username: str

    import_labels_as_tags: bool = False
    label_template: str = '{{label}}'


class ListaflowTask(Issue):
    ASSIGNEE = 'listaflowassignee'
    ID = 'listaflowid'
    REQUIRED = 'listaflowrequired'
    INTERFACE_TYPE = 'listaflowinterfacetype'
    LABEL = 'listaflowlabel'

    UDAS = {
        ASSIGNEE: {
            'type': 'string',
            'label': 'Listaflow assignee',
        },
        ID: {
            'type': 'string',
            'label': 'Listaflow task id',
        },
        REQUIRED: {
            'type': 'string',
            'label': 'Listaflow task required flag',
        },
        INTERFACE_TYPE: {
            'type': 'string',
            'label': 'Listaflow interface type',
        },
        LABEL: {
            'type': 'string',
            'label': 'Listaflow label',
        },
    }

    UNIQUE_KEY = (ID,)

    def to_taskwarrior(self):
        return {
            'project': 'Listaflow',
            'priority': self.origin['default_priority'],
            'annotations': self.record.get('annotations', []),
            'tags': self.get_tags(),
            'entry': self.parse_date(self.record.get('start')),
            'due': self.record.get('scheduled') + relativedelta.relativedelta(days=+1),
            'scheduled': self.record.get('scheduled'),
            'wait': self.record.get('scheduled') + relativedelta.relativedelta(days=-1),
            self.ASSIGNEE: self.record['assignee']['display_name'],
            self.ID: self.record['id'],
            self.REQUIRED: self.record['required'],
            self.INTERFACE_TYPE: self.record['interface_type'],
            self.LABEL: self.record['label'],
        }

    def get_tags(self):
        return []

    def get_default_description(self):
        return self.build_default_description(title=self.record['label'])


class ListaflowClient(ServiceClient):
    def __init__(self, username):
        self.username = username
        self.list_info = {}

    def _get_sprint_details(self) -> dict[str, str]:
        response = requests.get(LISTS_URL, headers=HEADERS)
        lists = self.json_response(response)
        for checklist in lists['results']:
            if checklist['name'].lower() == LIST_NAME.lower() and checklist['status'] in ['TO_DO', 'IN_PROGRESS', 'PAST_DUE']:
                return {
                    'id': checklist['id'],
                    'start': checklist['run']['start_date'],
                    'end': checklist['run']['end_date'],
                }
        return {}

    def _query_tasks(self, list_id: str):
        response = requests.get(TASK_URL.format(username=self.username, list_id=list_id), headers=HEADERS)
        return self.json_response(response)

    def get_scheduled_date(self, weekday, num):
        start_date = datetime.fromisoformat(self.list_info['start'])
        return start_date + relativedelta.relativedelta(days=-1, weekday=weekday(+num))

    def get_weekday_from_label(self, label):
        if ' - ' not in label:
            return None, None
        week_num, day = label.split(' - ')
        week_num = int(''.join(x for x in week_num if x.isdigit()))
        days_map = {
            'monday': relativedelta.MO,
            'tuesday': relativedelta.TU,
            'wednesday': relativedelta.WE,
            'thursday': relativedelta.TH,
            'friday': relativedelta.FR,
            'saturday': relativedelta.SA,
            'sunday': relativedelta.SU,
        }
        return week_num, days_map.get(day.lower())

    def get_issues(self):
        self.list_info = self._get_sprint_details()
        if not self.list_info:
            return []
        all_tasks = self._query_tasks(self.list_info['id'])
        parents = {task['id']: task for task in all_tasks if task['interface_type'] == 'subsection'}
        tasks = []
        for task in all_tasks:
            if task['interface_type'] == 'subsection' or task['completed']:
                continue
            parent = parents.get(task['parent'])
            if not parent:
                continue
            week_num, day = self.get_weekday_from_label(parent['label'])
            if not week_num or not day:
                continue
            task['scheduled'] = self.get_scheduled_date(day, week_num)
            task['parent'] = parent['label']
            task["start"] = self.list_info["start"]
            task["end"] = self.list_info["end"]
            tasks.append(task)
        return tasks


class ListaflowService(IssueService):
    ISSUE_CLASS = ListaflowTask
    CONFIG_SCHEMA = ListaflowConfig
    CONFIG_PREFIX = 'listaflow'

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.client = ListaflowClient(username=self.config.get("username"))

    def get_owner(self, issue):
        return self.config.get("username")

    def issues(self):
        for issue in self.client.get_issues():
            yield self.get_issue_for_record(issue)

# if __name__ == '__main__':
#     client = ListaflowClient(username='navin')
#     print(client.get_issues())
