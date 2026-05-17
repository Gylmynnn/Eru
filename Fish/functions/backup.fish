function backup
    set -l file $argv[1]

    if test -e $file
        cp -r $file "$file.backup."(date +%Y%m%d-%H%M%S)
        echo "Backup created"
    else
        echo "File/folder not found"
    end
end
