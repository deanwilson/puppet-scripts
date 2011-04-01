#!/bin/bash
# tested on 0.25

usage () {

cat<<EOU
$appname - Copyright (c) 2011 Dean Wilson - Licensed under the GPLv2

$appname lists files that puppet isn't currently managing in the given
directory. Without arguments $appname shows the files in the current
working directory.

The directory to check should always be the last argument.

Usage: $appname [-r] [-i] [directory]
  -i
    Invert the check and show files that puppet isn't managing.
  -r
    Show all puppet managed files in the given directory and subdirectories
  -h
    This help and usage information.

Usage: $appname

Examples:
  # show all puppet managed files in the /etc/mcollective directory.
  $appname /etc/mcollective

  # show all unmanaged files in /etc/nagios and any subdirectories
  $appname -r -i /etc/nagios/

EOU
exit 0
}

#################################################################

appname=$(basename "$0")
comm="comm -12"

while getopts "irh" option
do
case $option in
    i ) comm="comm -13" ;;
    r ) recursive=1 ;;
    h ) usage ;;
    * ) usage
  esac
done

# grab the non-getopts option
shift $(($OPTIND - 1))
target="${1-$(pwd)}"
target="${target%/}"

if [ -n "$recursive" ];then
  lister="find $target"
else
  lister="ls -d1 $target/*"
fi

catalog_filelist=$(mktemp -q /tmp/$appname.XXXXXX)
lister_filelist=$(mktemp -q /tmp/$appname.XXXXXX)

# better clean up
trap "rm -f $catalog_filelist $lister_filelist" 0 1 2 15

# get files puppet knows about - you might not need both of these.
(
  grep -h "title: /" /var/lib/puppet/client_yaml/catalog/*.yaml | awk '{ print $NF }' ;
  sed -e '/"File\[/!d' -e 's/"File\[//' -e 's/\]"://' -e 's/ //g' < /var/lib/puppet/state/state.yaml
) | sort > $catalog_filelist

$lister | sort > $lister_filelist

$comm $catalog_filelist $lister_filelist
