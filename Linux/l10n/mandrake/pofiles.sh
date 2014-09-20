#!/bin/sh

PO_PATH="/home/dmytro/Development/i18n/POFILES/"

files="DrakX/DrakX-uk.po \
	MandrakeUpdate/MandrakeUpdate-uk.po \
	grpmi-uk.po\
	gsu-uk.po \
	imlib-uk.po \
	urpmi-uk.po \
	xmms/xmms-uk.po"

echo '<?php $PO = array ('
for file in $files
do
    FILE=${PO_PATH}${file}
    [  $FIRST ] && { echo "," ; };  export FIRST=1
    echo -ne array\(\"`basename $file`\" 
    msgfmt -v -o /dev/null ${FILE} 2>&1 | perl -e '$line = <>; \
    print ",", (($line =~ /([0-9]+) translated messages/) ? $1 : 0);  \
    print ",", (($line =~ /([0-9]+) fuzzy translations/) ? $1 : 0);  \
    print ",", (($line =~ /([0-9]+) untranslated messages/) ? $1 : 0), ")" '
    cp ${FILE} .
done

echo -e '\n); ?>'
