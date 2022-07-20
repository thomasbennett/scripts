cd $PROJPATH
if [[ -n $(git status -s) ]]; then
    echo 'ERROR :: Files have been modified on the server...'
    git status -s;
fi;
