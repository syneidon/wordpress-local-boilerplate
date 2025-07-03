#!/bin/bash

wget https://wordpress.org/latest.zip
unzip latest.zip .
mv wordpress/* .
rm -rf latest.zip wordpress

echo "Done."