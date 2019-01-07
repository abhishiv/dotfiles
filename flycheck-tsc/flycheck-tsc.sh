#!/bin/bash

echo $1
INODE=`stat -f '%i' "$1"`
while ! test -f "/tmp/$INODE"; do
    sleep 1
done

echo "$(</tmp/$INODE )"

rm -rf "/tmp/$INODE"
