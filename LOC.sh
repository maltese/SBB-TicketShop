#!/bin/sh
# Count the number of lines of code in all .h and .m files
# in and below the current directory

wc -l `find . -regex ".*\.\([hm]\)"`
