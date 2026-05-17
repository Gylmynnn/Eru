function pomodoro
    set -l pomo_options_work 45
    set -l pomo_options_break 10

    set -l val $argv[1]
    
    if test "$val"
        if test "$val" = "work"
            echo "work" | lolcat
            notify-send "Work session start, Lets do it"
            timer {$pomo_options_work}m
            notify-send "Work session done, Relax :) 毎"
        else if test "$val" = "break"
            echo "break" | lolcat
            notify-send "Time to break dude"
            timer {$pomo_options_break}m
            notify-send "break session done lets go again 毎"
        end
    end
end

