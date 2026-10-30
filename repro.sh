#!/bin/sh
# Builds the site once per value of MY_SECRET and prints dist/index.html.
for v in 'plain' 'pa$$ss' 'pa$&ss' "pa\$'ss" 'pa$`ss'; do
  rm -rf dist
  printf '== MY_SECRET=%s\n' "$v"
  MY_SECRET="$v" npx astro build 2>&1 | grep -E 'PARSE_ERROR' | head -1
  [ -f dist/index.html ] && cat dist/index.html && echo
done
