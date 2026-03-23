# mail-digest

Daily email digest automation for macOS Mail.app. Generates **two separate digests** — one for unread emails and one for all emails from the previous day. Each digest uses LLM-based classification with Critical/Important/Normal tiers.

## Features

- **Dual digest system:**
  - **Unread digest:** New unread emails (marked as read after processing)
  - **Yesterday's digest:** All emails from previous day (regardless of read status)
- **Independent tier classification:** Each digest has its own 🔴 Critical / 🟠 Important / ⚪ Normal structure
- **LLM-based priority classification:** Uses AI to understand context and intent
- **Scam detection:** LLM flags suspicious patterns
- **Discord Component v2 output:** Clean hierarchical formatting
- **Auto mark-as-read:** Unread emails marked as read after digest (yesterday's emails left as-is)

## Files

- `scripts/fetch-unread.scpt` — Fetch new unread emails
- `scripts/fetch-yesterday.scpt` — Fetch all emails from previous day
- `scripts/mark-read.scpt` — Mark unread emails as read
- `SKILL.md` — This documentation

## Output Format

```
account|||subject|||sender|||date|||id
```

## Daily Workflow

1. **8:00 AM**: Cron triggers isolated agent session
2. **Fetch unread**: Get new unread emails, classify with LLM, send digest, mark as read
3. **Fetch yesterday**: Get all emails from previous day, classify with LLM, send digest, leave as-is

## License

MIT
