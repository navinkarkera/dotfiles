#!/usr/bin/env -S mise x python@3.11 -- python
#
# timew-fzf
#
# A timewarrior extension to list and restart
# recently tracked intervals with the help of fzf

import sys

from pyfzf.pyfzf import FzfPrompt
from timewreport.parser import TimeWarriorParser


def tags2key(tags):
    """A hashable string from a list of tags"""
    return "|".join(sorted(tags))


def get_recent_uniquelly_tagged_intervals(intervals):
    # Filter out open intervals
    intervals = [i for i in intervals if not i.is_open()]

    tags2interval = dict()
    for interval in intervals:
        key = tags2key(interval.get_tags())
        tags2interval[key] = interval

    intervals = list(tags2interval.values())
    intervals.sort(key=lambda i: i.get_start(), reverse=True)

    return intervals


def get_lines_for_fzf(intervals):
    """
    Get lines to feed to fzf. We used | to delimit fields in the output
    which means you can not use | within your timewarrior tags if you want this to work
    """
    lines = []
    for interval in get_recent_uniquelly_tagged_intervals(intervals):
        tags = interval.get_tags()
        lines.extend(tags)
    return lines


if __name__ == '__main__':
    # Get the parser, config and intervals
    parser = TimeWarriorParser(sys.stdin)
    tw_config = parser.get_config()
    intervals = parser.get_intervals()

    # Launch fzf and get a selection
    FzfPrompt().prompt(get_lines_for_fzf(intervals), "--print-query --bind 'enter:become(timew tag {} && timew stop),ctrl-e:become(timew tag {} && timew stop && timew start),ctrl-n:become(timew tag {q} && timew stop)'")
