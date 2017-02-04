#!bin/bash

rm -rf ./themes/next_back/next
cp -r ./themes/next ./themes/next_back
hexo clean
hexo s -g
