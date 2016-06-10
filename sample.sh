#! /bin/sh

if test -z "$1"
then
  echo 'Extract a small sample from a large data file.'
  echo 'The first argument is the input file.'
  echo 'The other two arguments are optional and'
  echo 'determine the approximate number of output lines (default 10) and'
  echo 'the number of header lines to include (default 1).'
  echo 'The first and only argument is the input file.'
  echo
  echo 'Examples:'
  echo
  echo '    $ sample data/2010/118-0.csv > excerpt/2010/118-0.csv'
  echo '    $ sample data/2010/118-0.csv 100 > excerpt/2010/118-0.csv'
  echo '    $ sample data/2010/118-0.csv 100 1 > excerpt/2010/118-0.csv'
  echo
  exit 22 # EINVAL
elif test -r "$1"
then
  awk "NR <= ${3:-1} || \
       NR % $(expr "$(cat "$1" | wc -l)" / "${2:-10}") == ${3:-1} + 1" "$1"
else
  echo "error: cannot read file '$1'" >&2
  exit 5 # EIO
fi
