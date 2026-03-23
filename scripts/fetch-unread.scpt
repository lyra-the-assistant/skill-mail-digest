#!/usr/bin/env osascript
-- Fetch unread emails from Mail.app (no classification - LLM will handle that)
-- Output: account|||subject|||sender|||date|||id

on run
    tell application "Mail"
        set output to ""
        
        repeat with acct in accounts
            set acctName to name of acct
            try
                set inboxFolder to mailbox "INBOX" of acct
                set unreadMsgs to (every message of inboxFolder whose read status is false)
                
                repeat with msg in unreadMsgs
                    set msgSubject to subject of msg
                    set msgSender to sender of msg
                    set msgDate to date received of msg
                    set msgId to id of msg
                    
                    -- Output format: delimited string (raw data, no classification)
                    set output to output & acctName & "|||" & msgSubject & "|||" & msgSender & "|||" & msgDate & "|||" & msgId & "\n"
                    
                end repeat
            on error errMsg
                -- Skip accounts with errors
            end try
        end repeat
        
        return output
    end tell
end run
