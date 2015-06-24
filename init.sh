#!/bin/bash
INPUT=repos.csv
OLDIFS=$IFS
IFS=,
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read reponame repourl
do
    if [[ -n "$reponame" && -n "$repourl" && $reponame != "reponame" && $repourl != "repourl" ]]; then
        echo "Creating $reponame ..."
        mkdir "$reponame"
        cd "$reponame"
        git svn clone --no-minimize-url -r HEAD "$repourl"
            cd ro
            git remote add origin https://github.com/jobava-mozilla/mirror-"$reponame".git
            git push -u --force origin master
            cd ..
        cd ..
    fi
done < $INPUT
IFS=$OLDIFS

echo "*~" > .gitignore
echo ".svn" >> .gitignore
echo ".git" >> .gitignore

