#!/bin/bash

git checkout $(git log -n 2 | grep commit | tail -n 1 | awk -e '{ print $2 }')
