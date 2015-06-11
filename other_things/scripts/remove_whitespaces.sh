#!/bin/bash
# Script to remove whitespaces from our repository's lua files
# Script ßý LeMagnesium, 2015
# (Note: You need this : https://github.com/LeMagnesium/mucro )

# Go to repo root
mydir="`dirname "$0"`"
test -d "$mydir" && cd "$mydir/../../"

# Get all lua file's names
luafiles=$(mucro '.lua'$ -r . -b)
sed -i 's/[ \t]*$//' $luafiles

# Done
echo `git status`
echo "Done"

#EOF
