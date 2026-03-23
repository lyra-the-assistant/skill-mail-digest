#!/usr/bin/env osascript
-- Mark unread emails as read

on run
    tell application "Mail"
        set readCount to 0
        
        repeat with acct in accounts
            try
                set inboxFolder to mailbox "INBOX" of acct
                set unreadMsgs to (every message of inboxFolder whose read status is false)
                repeat with msg in unreadMsgs
                    set read status of msg to true
                    set readCount to readCount + 1
                end repeat
            on error
                -- Skip accounts with errors
            end try
        end repeat
        
        return "Marked " & readCount & " unread emails as read"
    end tell
end run
