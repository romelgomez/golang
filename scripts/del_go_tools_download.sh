#!/bin/bash

echo "Removing Download if it exists"

find $PWD/.tools -name "*.tar.gz" -type f -delete
