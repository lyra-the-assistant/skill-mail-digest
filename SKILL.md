# mail-digest

Daily email digest automation for macOS Mail.app. Fetches unread emails, categorizes by priority, generates formatted Discord reports, and marks emails as read.

## Features

- **Priority-based categorization:**
  - 🔴 Critical: Job platforms (实习僧网, 招聘, 简历 submissions)
  - 🟠 Important: Work events, conferences, GitHub notifications
  - ⚪ Normal: Google Scholar alerts, social notifications, newsletters
- **Scam detection:** Flags suspicious emails (ETH refunds, etc.)
- **Discord Component v2 output:** Clean hierarchical formatting
- **Auto mark-as-read:** Processes emails after digest generation

## Requirements

- macOS with Mail.app configured
- AppleScript Automation permission for Mail.app (System Settings → Privacy & Security → Automation)
- OpenClaw with message tool capabilities

## Usage

### Manual Run

```bash
# Fetch and display unread emails
osascript scripts/fetch-unread.scpt

# Mark all unread as read
osascript scripts/mark-read.scpt
```

### As OpenClaw Skill

The agent will automatically:
1. Run `fetch-unread.scpt` to get categorized email list
2. Generate Discord-formatted digest
3. Send to configured channel
4. Run `mark-read.scpt` to clean up

### Daily Cron Schedule

```json
{
  "name": "daily-mail-digest",
  "schedule": {"kind": "cron", "expr": "0 8 * * *", "tz": "Asia/Shanghai"},
  "payload": {
    "kind": "systemEvent",
    "text": "Run mail-digest skill: fetch unread emails, generate priority-based Discord digest, mark as read"
  },
  "sessionTarget": "main"
}
```

## Customization

Edit `scripts/fetch-unread.scpt` to adjust priority rules:

```applescript
-- Critical: Job/recruitment platforms
if msgSubject contains "实习僧网" or msgSubject contains "招聘" then
    set priority to "critical"
end if

-- Important: Work-related
if msgSubject contains "CVPR" or msgSubject contains "conference" then
    set priority to "important"
end if
```

## Files

- `scripts/fetch-unread.scpt` — Fetch and categorize unread emails
- `scripts/mark-read.scpt` — Mark all unread as read
- `SKILL.md` — This documentation

## License

MIT
