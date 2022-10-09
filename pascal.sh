#!/bin/bash
CURRENT_DIR='.'

# Get last modified file
get_recent_file () {
    FILE=$(ls -Art1 ${CURRENT_DIR} | tail -n 1)
    if [ ! -f ${FILE} ]; then
        CURRENT_DIR="${CURRENT_DIR}/${FILE}"
        get_recent_file
    fi
    echo $FILE
    exit
}

# Only filename, without extension
FILE=$(get_recent_file)
FILE="${FILE%%.*}"
# echo $FILE

# Compile Pascal program
fpc -O1 -XS -o${FILE} "$FILE.pas"

# Remove executable
rm "$FILE.o"

STR=$'\nRunning your program:'
echo "$STR"

# Run Pascal program and remove executable
./${FILE}
rm "$FILE"
