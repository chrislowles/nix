getmp3 () {
	yt-dlp --cookies-from-browser firefox -x --audio-format mp3
	# getmp3 https://youtu.be/dQw4w9WgXcQ
}

getmp4 () {
	yt-dlp --cookies-from-browser firefox -f "bestvideo[ext!=webm]+bestaudio[ext!=webm]/best[ext!=webm]" --recode-video mp4
	# getmp4 https://youtu.be/dQw4w9WgXcQ
}

pso () {
	ping -c 1
	# ping something once
}