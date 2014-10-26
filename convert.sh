#!/bin/bash
# this script converts large movie files to flv files
INPATH=/path/to/orig/movies
OUTPATH=/path/to/converted/movies
for f in ${INPATH}/*.*
do
    filename="${f##*/}" 
    basename="${filename%.*}"
    ext="${f##*.}"
    if [ ! -f "${OUTPATH}/${basename}.flv" ]
    then
        avconv -v quiet -i "${INPATH}/${filename}" \
            -c:v libx264 -crf 23 -vf scale=640:-1 -c:a libmp3lame -q:a 3 -ar 44100 -threads 1 "${OUTPATH}/${basename}.flv" 2>> convert_errors.log
        echo "finished converting ${f}"
        echo "finished converting ${f}" >> convert_results.log
	# and we remove the original file to make some space...
	rm -f ${INPATH}/${filename}
    fi
done
exit 0
