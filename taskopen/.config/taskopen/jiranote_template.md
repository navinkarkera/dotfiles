# ${TASK_DESCRIPTION} #${TASK_UUID}

## Task Comments

```bash
comment=""
[ ! -z "${comment}" ] && jira issue comment add ${JIRA_ID} "${comment}"
jira issue show ${JIRA_ID} --comments 2 --plain | awk '/Comments/{y=1;next}y' | head -n -5
```
