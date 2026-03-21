#!/usr/bin/env osascript
-- Fetch unread emails from Mail.app and categorize by priority
-- Output: account|||subject|||sender|||date|||id|||priority|||isScam

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
                    
                    -- Determine priority
                    set priority to "normal"
                    set subjectLower to my toLowercase(msgSubject)
                    set senderLower to my toLowercase(msgSender)
                    
                    -- CRITICAL: Job platforms and recruitment
                    if subjectLower contains "实习僧网" or subjectLower contains "实习" or ¬
                       subjectLower contains "招聘" or subjectLower contains "简历" or ¬
                       subjectLower contains "求职" or subjectLower contains "面试" or ¬
                       subjectLower contains "候选人" or subjectLower contains "应聘" then
                        set priority to "critical"
                    end if
                    
                    -- IMPORTANT: Work events, conferences, GitHub
                    if priority is "normal" then
                        if subjectLower contains "cvpr" or subjectLower contains "iccv" or ¬
                           subjectLower contains "eccv" or subjectLower contains "neurips" or ¬
                           subjectLower contains "icml" or subjectLower contains "icra" or ¬
                           subjectLower contains "iros" or subjectLower contains "rss" or ¬
                           subjectLower contains "conference" or subjectLower contains "summit" or ¬
                           subjectLower contains "workshop" or subjectLower contains "symposium" or ¬
                           subjectLower contains "github" or subjectLower contains "copilot" or ¬
                           subjectLower contains "邀请" or subjectLower contains "参会" then
                            set priority to "important"
                        end if
                    end if
                    
                    -- NORMAL: Google Scholar (explicit downgrade)
                    if senderLower contains "scholaralerts" or subjectLower contains "new related research" then
                        set priority to "normal"
                    end if
                    
                    -- Scam detection
                    set isScam to "false"
                    if (subjectLower contains "eth" and subjectLower contains "refund") or ¬
                       (subjectLower contains "eth" and subjectLower contains "recovery") or ¬
                       subjectLower contains "locked" and subjectLower contains "ready to refund" then
                        set isScam to "true"
                    end if
                    
                    -- Output format: delimited string
                    set output to output & acctName & "|||" & msgSubject & "|||" & msgSender & "|||" & msgDate & "|||" & msgId & "|||" & priority & "|||" & isScam & "\n"
                    
                end repeat
            on error errMsg
                -- Skip accounts with errors
            end try
        end repeat
        
        return output
    end tell
end run

on toLowercase(str)
    set lowerStr to ""
    repeat with char in str
        set charCode to (id of char)
        if charCode ≥ 65 and charCode ≤ 90 then
            set lowerStr to lowerStr & (character id (charCode + 32))
        else
            set lowerStr to lowerStr & char
        end if
    end repeat
    return lowerStr
end toLowercase
