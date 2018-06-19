#cd into max-depth=2 dir
ls $1 | while read f; do convert -quality 60% $f/* $f/*; done
