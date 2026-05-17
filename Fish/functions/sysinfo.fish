function sysinfo
    echo "OS:" (uname -a)
    echo "Shell:" $SHELL
    echo "User:" (whoami)
    echo "Uptime:" (uptime -p)
    echo "Memory:"
    free -h
    echo "Disk:"
    df -h /
end
