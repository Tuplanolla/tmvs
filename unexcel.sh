#! /bin/sh

if test -z "$1"
then
  echo 'Convert an Excel file into comma-separated value files.'
  echo 'The first and only argument is the input file.'
  echo "The input file must have the extension '.xlsx'."
  echo 'The converted files appear in the current working directory and'
  echo "their names follow the format '\$name-\$sheet.xlsx',"
  echo "where '\$name' is the original name and"
  echo "'\$sheet' is the sheet number (starting from 0 and counting up)."
  echo
  echo 'Examples:'
  echo
  echo '    $ unexcel.sh data/2010/118.xlsx'
  echo '    $ cd data/2010 && unexcel 118.xlsx'
  echo
  exit 22 # EINVAL
elif test -r "$1"
then
  ssconvert "$1" "$(basename "$1" .xlsx)-%n.csv" \
  --export-file-per-sheet \
  --export-type 'Gnumeric_stf:stf_assistant' \
  --export-options 'separator=| quoting-mode=never quoting-on-whitespace=false'
else
  echo "error: cannot read file '$1'" >&2
  exit 5 # EIO
fi
