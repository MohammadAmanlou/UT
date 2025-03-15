#!/usr/bin/env bash

URL="https://www.sqlite.org"

SQLITE_FILE_PATH=$(wget -qO- "$URL/download.html" | grep -oP '[0-9]+/sqlite-autoconf-[0-9]+\.tar\.gz' | head -n 1)
FILE_NAME=$(basename $SQLITE_FILE_PATH)
DIR_NAME=$(basename $SQLITE_FILE_PATH .tar.gz)

wget -O "/tmp/$FILE_NAME" "$URL/$SQLITE_FILE_PATH"

pushd /tmp
tar xvfz $FILE_NAME
pushd $DIR_NAME
./configure --prefix=/usr/local
make
sudo make install
popd
popd

echo "Sqlite3 installed successfully!"
