
ffmpeg -ss $2 -to $3 -i $1 -c copy clip.mp4
ffmpeg -i clip.mp4 -filter:v "crop=min(iw\,ih):min(iw\,ih):(iw-min(iw\,ih))/2:(ih-min(iw\,ih))/2" square.mp4
ffmpeg -i square.mp4 -filter:v "fps=60" square_fps60.mp4
ffmpeg -i square_fps60.mp4 -vf "fps=60,scale=420:-1:flags=lanczos,palettegen" palette.png
ffmpeg -i square_fps60.mp4 -i palette.png -filter_complex "fps=60,scale=420:-1:flags=lanczos[x];[x][1:v]paletteuse" output.gif
gifsicle -O3 --colors 128 output.gif -o output_optimized.gif
