#!/usr/bin/env osascript
-- Fetch all emails from previous day (read or unread)
-- Output: account|||subject|||sender|||date|||id

on run
    tell application "Mail"
        set output to ""
        set currentDate to current date
        set yesterdayStart to currentDate - (1 * days)
        set yesterdayStart to yesterdayStart - (time of yesterdayStart)
        set yesterdayEnd to yesterdayStart + (1 * days) - 1
        
        repeat with acct in accounts
            set acctName to name of acct
            try
                set inboxFolder to mailbox "INBOX" of acct
                set yesterdayMsgs to (every message of inboxFolder whose date received ≥ yesterdayStart and date received ≤ yesterdayEnd)
                
                repeat with msg in yesterdayMsgs
                    set msgSubject to subject of msg
                    set msgSender to sender of msg
                    set msgDate to date received of msg
                    set msgId to id of msg
                    set output to output & acctName & "|||" & msgSubject & "|||" & msgSender & "|||" & msgDate & "|||" & msgId & "\n"
                end repeat
            on error
                -- Skip accounts with errors
            end try
        end repeat
        
        return output
    end tell
end run
