#Requires AutoHotkey v2.0


^!#h:: { ; Ctrl + Win + H
    ; Define the PowerShell command you want to run
    PowerShellCommand := 'Move-ActiveWindow -Desktop 0'

    ; Prepare the full PowerShell command to run silently
    Command := 'PowerShell -NoProfile -NonInteractive -WindowStyle Hidden -Command "' PowerShellCommand '"'

    ; Use Run to execute the command
    Run(Command, , "Hide")
}

^!#j:: { ; Ctrl + Win + J
    ; Define the PowerShell command you want to run
    PowerShellCommand := 'Move-ActiveWindow -Desktop 1'

    ; Prepare the full PowerShell command to run silently
    Command := 'PowerShell -NoProfile -NonInteractive -WindowStyle Hidden -Command "' PowerShellCommand '"'

    ; Use Run to execute the command
    Run(Command, , "Hide")
}

^!#k:: { ; Ctrl + Win + K
    ; Define the PowerShell command you want to run
    PowerShellCommand := 'Move-ActiveWindow -Desktop 2'

    ; Prepare the full PowerShell command to run silently
    Command := 'PowerShell -NoProfile -NonInteractive -WindowStyle Hidden -Command "' PowerShellCommand '"'

    ; Use Run to execute the command
    Run(Command, , "Hide")
}

^!#l:: { ; Ctrl + Win + L
    ; Define the PowerShell command you want to run
    PowerShellCommand := 'Move-ActiveWindow -Desktop 3'

    ; Prepare the full PowerShell command to run silently
    Command := 'PowerShell -NoProfile -NonInteractive -WindowStyle Hidden -Command "' PowerShellCommand '"'

    ; Use Run to execute the command
    Run(Command, , "Hide")
}

^!#;:: { ; Ctrl + Win + ;
    ; Define the PowerShell command you want to run
    PowerShellCommand := 'Move-ActiveWindow -Desktop 4'

    ; Prepare the full PowerShell command to run silently
    Command := 'PowerShell -NoProfile -NonInteractive -WindowStyle Hidden -Command "' PowerShellCommand '"'

    ; Use Run to execute the command
    Run(Command, , "Hide")
}

^!#':: { ; Ctrl + Win + '
    ; Define the PowerShell command you want to run
    PowerShellCommand := 'Move-ActiveWindow -Desktop 5'

    ; Prepare the full PowerShell command to run silently
    Command := 'PowerShell -NoProfile -NonInteractive -WindowStyle Hidden -Command "' PowerShellCommand '"'

    ; Use Run to execute the command
    Run(Command, , "Hide")
}

^!#Enter:: { ; Ctrl + Win + enter
    ; Define the PowerShell command you want to run
    PowerShellCommand := 'Move-ActiveWindow -Desktop 6'

    ; Prepare the full PowerShell command to run silently
    Command := 'PowerShell -NoProfile -NonInteractive -WindowStyle Hidden -Command "' PowerShellCommand '"'

    ; Use Run to execute the command
    Run(Command, , "Hide")
}

^!#\:: { ; Ctrl + Win + \
    ; Define the PowerShell command you want to run
    PowerShellCommand := 'Move-ActiveWindow -Desktop 7'

    ; Prepare the full PowerShell command to run silently
    Command := 'PowerShell -NoProfile -NonInteractive -WindowStyle Hidden -Command "' PowerShellCommand '"'

    ; Use Run to execute the command
    Run(Command, , "Hide")
}


;=================== switch desktop ================

; turned off because the keyboard shortcut is slow

;^#h:: { ; Ctrl + Win + H
;    ; Define the PowerShell command you want to run
;    PowerShellCommand := 'Switch-Desktop -Desktop 0'
;
;    ; Prepare the full PowerShell command to run silently
;    Command := 'PowerShell -NoProfile -NonInteractive -WindowStyle Hidden -Command "' PowerShellCommand '"'
;
;    ; Use Run to execute the command
;    Run(Command, , "Hide")
;}
;
;^#j:: { ; Ctrl + Win + J
;    ; Define the PowerShell command you want to run
;    PowerShellCommand := 'Switch-Desktop -Desktop 1'
;
;    ; Prepare the full PowerShell command to run silently
;    Command := 'PowerShell -NoProfile -NonInteractive -WindowStyle Hidden -Command "' PowerShellCommand '"'
;
;    ; Use Run to execute the command
;    Run(Command, , "Hide")
;}
;
;^#k:: { ; Ctrl + Win + K
;    ; Define the PowerShell command you want to run
;    PowerShellCommand := 'Switch-Desktop -Desktop 2'
;
;    ; Prepare the full PowerShell command to run silently
;    Command := 'PowerShell -NoProfile -NonInteractive -WindowStyle Hidden -Command "' PowerShellCommand '"'
;
;    ; Use Run to execute the command
;    Run(Command, , "Hide")
;}
;
;^#l:: { ; Ctrl + Win + L
;    ; Define the PowerShell command you want to run
;    PowerShellCommand := 'Switch-Desktop -Desktop 3'
;
;    ; Prepare the full PowerShell command to run silently
;    Command := 'PowerShell -NoProfile -NonInteractive -WindowStyle Hidden -Command "' PowerShellCommand '"'
;
;    ; Use Run to execute the command
;    Run(Command, , "Hide")
;}
;
;^#;:: { ; Ctrl + Win + ;
;    ; Define the PowerShell command you want to run
;    PowerShellCommand := 'Switch-Desktop -Desktop 4'
;
;    ; Prepare the full PowerShell command to run silently
;    Command := 'PowerShell -NoProfile -NonInteractive -WindowStyle Hidden -Command "' PowerShellCommand '"'
;
;    ; Use Run to execute the command
;    Run(Command, , "Hide")
;}
;
;^#':: { ; Ctrl + Win + '
;    ; Define the PowerShell command you want to run
;    PowerShellCommand := 'Switch-Desktop -Desktop 5'
;
;    ; Prepare the full PowerShell command to run silently
;    Command := 'PowerShell -NoProfile -NonInteractive -WindowStyle Hidden -Command "' PowerShellCommand '"'
;
;    ; Use Run to execute the command
;    Run(Command, , "Hide")
;}
;
;^#Enter:: { ; Ctrl + Win + enter
;    ; Define the PowerShell command you want to run
;    PowerShellCommand := 'Switch-Desktop -Desktop 6'
;
;    ; Prepare the full PowerShell command to run silently
;    Command := 'PowerShell -NoProfile -NonInteractive -WindowStyle Hidden -Command "' PowerShellCommand '"'
;
;    ; Use Run to execute the command
;    Run(Command, , "Hide")
;}
;
;^#\:: { ; Ctrl + Win + \
;    ; Define the PowerShell command you want to run
;    PowerShellCommand := 'Switch-Desktop -Desktop 7'
;
;    ; Prepare the full PowerShell command to run silently
;    Command := 'PowerShell -NoProfile -NonInteractive -WindowStyle Hidden -Command "' PowerShellCommand '"'
;
;    ; Use Run to execute the command
;    Run(Command, , "Hide")
;}
;
