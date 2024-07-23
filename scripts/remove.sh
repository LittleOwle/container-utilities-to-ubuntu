#!/bin/env bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run with root"
    exit 1
fi

EXTERNALS_SOURCE_FOLDER=/opt/owle-externals/source
EXTERNALS_BUILD_FOLDER=/opt/owle-externals/build

rm -rf $EXTERNALS_SOURCE_FOLDER
rm -rf $EXTERNALS_BUILD_FOLDER

echo "remove done!"

exit 0
