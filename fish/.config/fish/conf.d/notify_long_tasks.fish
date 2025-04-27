function notify_long_tasks --on-event fish_postexec
    if test "$CMD_DURATION" -gt 5000
        set -l cmd_name (string split ' ' -- $argv)[1]

        if not contains $cmd_name ssh python psql node iex less cat
            set -l duration_sec (math "$CMD_DURATION / 1000")
            echo -e "\033]777;notify;Command finished in $duration_sec s;$argv\007"
        end
    end
end
