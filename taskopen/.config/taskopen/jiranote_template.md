# ${TASK_DESCRIPTION} #${TASK_UUID}

## Task Comments

```bash
comment=""
issue="${TASK_ID}"
[ ! -z "${comment}" ] && jira issue comment add ${issue} "${comment}"
jira issue show ${issue} --comments 2 --plain | awk '/Comments/{y=1;next}y' | head -n -5
```
