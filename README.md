# scheduled_reminder
## Remind pull request
- fill `settings.yml`

```
---
channel: 'general'
repo: 'user/repo'

...
```

- set env

```
# .env
GITHUB_ACCESS_TOKEN=personal_access_token #scope: repo
SLACK_BOT_TOKEN=slack_bot_token
PR_LABEL='waiting for review'
```

- run task
```
rake remind_pull_request
```

![sample](https://user-images.githubusercontent.com/42172002/132166956-cae0febe-57ee-4a20-88af-f5c2b270f492.jpg)
