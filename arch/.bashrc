getmp3 () {
	yt-dlp -x --audio-format mp3 --cookies-from-browser firefox
	# example: getmp3 https://youtu.be/NT9Cfuv5gZE
}

getmp4 () {
	yt-dlp -f "bestvideo[ext!=webm]+bestaudio[ext!=webm]/best[ext!=webm]" --recode-video mp4
	# example: getmp3 https://youtu.be/NT9Cfuv5gZE
}

pso () {
	ping -c 1
	# ping something once
}

flushall () {
	sudo pacman -Scc
	sudo pacman -Rns $(pacman -Qdtq)
	flatpak uninstall --unused
}

updateall () {
	yay
	flatpak update
	while
		read -p "Clear cache and uninstall orphans? (y/N)" answer
	do
		case $answer in
			([yY][eE][sS] | [yY]) flushall;;
			(*) break;;
		esac
	done
}