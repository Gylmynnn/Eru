function fzfv
    set file (
        fd . --hidden --exclude .git --type f | \
        fzf \
            --height 100% \
            --layout reverse \
            --border \
            --preview 'bat --style=numbers --color=always {}' \
            --preview-window right:60%
    )

    if test "$file"
        nvim $file
    end
end
