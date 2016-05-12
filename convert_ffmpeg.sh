#!/bin/bash
# this script converts large movie files to lower quality mp4 files
#VDPAU_DRIVER='nvidia' nice -n10 avconv -hwaccel vdpau -i $1 -strict experimental -s 720x480
INPATH=/path/to/reencode
ENCPATH=/run/shm
OUTPATH=/path/to/reencode/done
for f in ${INPATH}/*.*
do
    filename="${f##*/}" 
    basename="${filename%.*}"
    ext="${f##*.}"
    if [ ! -f "${OUTPATH}/${filename}" ]
    then
        #VDPAU_DRIVER='nvidia' \
        #    avconv -hwaccel vdpau -i "${INPATH}/${filename}" \
        #    -strict experimental -s 720x480 -threads auto "${ENCPATH}/${filename}"
	#VDPAU_DRIVER='nvidia' ffmpeg -hwaccel vdpau \
	VDPAU_DRIVER='nvidia' ffmpeg -hwaccel vdpau -i "${INPATH}/${filename}" \
		-vcodec h264 \
		-pass 1 \
		-b:v 1000k -minrate 800k -maxrate 2500k -bufsize 200k \
		-crf 22 \
		-strict experimental \
		-g 20 \
		-me_method zero \
		-threads 1 \
		"${ENCPATH}/${filename}"
        mv -f "${ENCPATH}/${filename}" ${OUTPATH}
            #-c:v libx264 -crf 23 -vf scale=640:-1 -c:a libmp3lame -q:a 3 -ar 44100 -threads 1 "${OUTPATH}/${basename}.flv" 2>> convert_errors.log
        #echo "finished converting ${f}"
        #echo "finished converting ${f}" >> convert_results.log
	    # and we remove the original file to make some space...
	    #rm -f ${INPATH}/${filename}
    fi
done
exit 0
