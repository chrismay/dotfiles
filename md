#!/bin/bash

f="$1.html"
cat /home/chrismay/bin/gfm_head.html > $f
/home/chrismay/bin/github-flavored-markdown.rb $1 >> $f &&\
echo "</html>" >> $f && firefox $f

