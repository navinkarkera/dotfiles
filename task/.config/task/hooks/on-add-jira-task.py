#!/usr/bin/env python

import sys
import json
from datetime import datetime, timedelta

def next_weekday(d, weekday):
    days_ahead = weekday - d.weekday()
    if days_ahead <= 0: # Target day already happened this week
        days_ahead += 7
    return d + timedelta(days_ahead)

task = json.loads(sys.stdin.readline())
if "In_progress" in task.get("tags", []):
    task["start"] = datetime.utcnow().strftime('%Y%m%dT%H%M%SZ')
    task["modified"] = datetime.utcnow().strftime('%Y%m%dT%H%M%SZ')

if "jiraid" in task and (datetime.utcnow().isocalendar().week - datetime(2022, 4, 18).isocalendar().week) % 2 == 1:
    task["due"] = next_weekday(datetime.utcnow(), 0).strftime('%Y%m%dT%H%M%SZ')
else:
    task["due"] = (next_weekday(datetime.utcnow(), 0) + timedelta(weeks=1)).strftime('%Y%m%dT%H%M%SZ')

print(json.dumps(task))

sys.exit(0)
