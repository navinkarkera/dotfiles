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
task = json.loads(sys.stdin.readline())
if ("In_progress" in task.get("tags", []) or "Need_Review" in task.get("tags", [])) and not task.get("start", ""):
    task["start"] = datetime.utcnow().strftime(midnight_format)
    task["modified"] = datetime.utcnow().strftime(midnight_format)

if "jiraid" in task:
    if (datetime.utcnow().isocalendar()[1] - datetime(2022, 4, 18).isocalendar()[1]) % 2 == 1:
        task["due"] = next_weekday(datetime.utcnow(), 0).strftime(midnight_format)
    else:
        if datetime.now().isocalendar()[2] == 1:
            task["due"] = datetime.utcnow().strftime(midnight_format)
        else:
            task["due"] = (next_weekday(datetime.utcnow(), 0) + timedelta(days=6)).strftime(midnight_format)

if "gmailurl" in task:
    task["due"] = datetime.utcnow().strftime(midnight_format)

print(json.dumps(task))

sys.exit(0)
