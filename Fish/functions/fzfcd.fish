function fzfcd
    set dir (find . -type d 2>/dev/null | fzf)

    if test "$dir"
        cd $dir
    end
end
