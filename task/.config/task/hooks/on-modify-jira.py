#!/usr/bin/env python

import json
import sys
from datetime import datetime, timedelta

midnight_format = '%Y%m%dT235959Z'


def next_weekday(d, weekday):
    days_ahead = weekday - d.weekday()
    if days_ahead <= 0:  # Target day already happened this week
        days_ahead += 7
    return d + timedelta(days_ahead)


sys.stdin.reconfigure(encoding='ascii', errors='ignore')
old_task = json.loads(sys.stdin.readline())
modified_task = json.loads(sys.stdin.readline())

if modified_task.get('githubupdatedat', 0) > old_task.get('githubupdatedat', 0):
    modified_task['tags'].append('new')

if (
    'In_progress' in modified_task.get('tags', []) or 'Need_Review' in modified_task.get('tags', [])
) and not modified_task.get('start', ''):
    modified_task['start'] = datetime.utcnow().strftime(midnight_format)
    modified_task['modified'] = datetime.utcnow().strftime(midnight_format)

if 'jiraid' in modified_task:
    if (datetime.utcnow().isocalendar()[1] - datetime(2022, 4, 18).isocalendar()[1]) % 2 == 1:
        modified_task['due'] = next_weekday(datetime.utcnow(), 0).strftime(midnight_format)
    elif datetime.now().isocalendar()[2] == 1:
        modified_task['due'] = datetime.utcnow().strftime(midnight_format)
    else:
        modified_task['due'] = (next_weekday(datetime.utcnow(), 0) + timedelta(days=6)).strftime(midnight_format)

print(json.dumps(modified_task))

sys.exit(0)
