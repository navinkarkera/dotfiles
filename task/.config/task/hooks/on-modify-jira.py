#!/usr/bin/env python

import sys
import json
from datetime import datetime, timedelta

midnight_format = '%Y%m%dT235959Z'

def next_weekday(d, weekday):
    days_ahead = weekday - d.weekday()
    if days_ahead <= 0: # Target day already happened this week
        days_ahead += 7
    return d + timedelta(days_ahead)

sys.stdin.reconfigure(encoding='utf-8', errors="ignore")
_ = sys.stdin.readline()
modified_task = json.loads(sys.stdin.readline())
if "In_progress" in modified_task.get("tags", []) and not modified_task.get("start", ""):
    modified_task["start"] = datetime.utcnow().strftime(midnight_format)
    modified_task["modified"] = datetime.utcnow().strftime(midnight_format)

if "jiraid" in modified_task:
    if (datetime.utcnow().isocalendar()[1] - datetime(2022, 4, 18).isocalendar()[1]) % 2 == 1:
        modified_task["due"] = next_weekday(datetime.utcnow(), 0).strftime(midnight_format)
    else:
        if datetime.now().isocalendar()[2] == 1:
            modified_task["due"] = datetime.utcnow().strftime(midnight_format)
        else:
            modified_task["due"] = (next_weekday(datetime.utcnow(), 0) + timedelta(weeks=2)).strftime(midnight_format)

print(json.dumps(modified_task))

sys.exit(0)
