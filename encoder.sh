#!/bin/bash
#ffmpeg -i input -acodec libfaac -vcodec mpeg4 -b 1200k -mbd 2 -flags +mv4+aic -trellis 2 -cmp 2 -subcmp 2 -metadata title=X output.mp4
ffmpeg=/opt/ffmpeg-nvenc/bin/ffmpeg
target_dir=/path/to/output
for file in /pvr-backup/*.ts
do
	filename_single=$(basename "$file")
	extension="${filename_single##*.}"
	filename="${filename_single%.*}"
	VDPAU_DRIVER='nvidia' $ffmpeg -i $file -s 1080x720 -c:a libmp3lame -b:a 128k -c:v nvenc -preset slow -metadata title=$filename $target_dir/$filename.mp4
done
exit 0
