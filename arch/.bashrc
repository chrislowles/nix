#alias getmp4="yt-dlp -f bestvideo[height=2160][ext=mp4][vcodec^=avc]+bestaudio[ext=m4a]/bestvideo[height=2160]+bestaudio --recode-video mp4" # getmp4 --cookies-from-browser firefox https://youtu.be/NT9Cfuv5gZE
#alias downloadwebsite="wget -mkEpnp" # downloadwebsite https://www.google.com/
alias quickping="ping -c 1" # qp google.com (ping something once)

getmp3 () {
	yt-dlp -x --audio-format mp3 --cookies-from-browser firefox
	# example: getmp3 https://youtu.be/NT9Cfuv5gZE
}

getmp4 () {
	yt-dlp -f bestvideo[height=2160][ext=mp4][vcodec^=avc]+bestaudio[ext=m4a]/bestvideo[height=2160]+bestaudio --recode-video mp4 --cookies-from-browser firefox
	# example: getmp3 https://youtu.be/NT9Cfuv5gZE
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