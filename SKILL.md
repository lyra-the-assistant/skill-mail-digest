# mail-digest

Daily email digest automation for macOS Mail.app. Fetches unread emails, uses LLM for intelligent priority classification, generates formatted Discord reports, and marks emails as read.

## Features

- **LLM-based priority classification:** Uses AI to understand context and intent
  - 🔴 Critical: Job applications, urgent deadlines, interviews scheduled today, security issues
  - 🟠 Important: Work events, conferences, relevant opportunities, action items
  - ⚪ Normal: Newsletters, social notifications, routine updates, Google Scholar
- **Scam detection:** LLM flags suspicious patterns (ETH refunds, phishing, etc.)
- **Discord Component v2 output:** Clean hierarchical formatting
- **Auto mark-as-read:** Processes emails after digest generation

## Requirements

- macOS with Mail.app configured
- AppleScript Automation permission for Mail.app
- OpenClaw with LLM capabilities

## Usage

### Manual Run

```bash
# Fetch raw unread emails (no classification)
osascript scripts/fetch-unread.scpt

# Mark all unread as read
osascript scripts/mark-read.scpt
```

### LLM Classification Prompt

The agent uses this logic to classify:

```
CRITICAL: Job applications/internships, urgent deadlines, interviews today, security alerts, 
          recruitment from 实习僧网/LinkedIn/Boss直聘, candidate submissions

IMPORTANT: Conference CFPs (CVPR, ICCV, NeurIPS, etc.), workshop invites, collaboration requests,
           GitHub notifications requiring action, billing alerts

NORMAL: Google Scholar alerts, social notifications, newsletters, automated digests,
        promotional emails, "you appeared in searches"
```

## Files

- `scripts/fetch-unread.scpt` — Fetch raw unread emails
- `scripts/mark-read.scpt` — Mark all unread as read
- `SKILL.md` — This documentation

## License

MIT
