function notify() {
	powershell.exe -command New-BurntToastNotification \
		-AppLogo "\"C:\\Users\\andre\\Pictures\\suse.png\"" \
		-Text "\"$@\""
}

function push() {
	curl -X POST \
		-H "content-type: application/json" \
		-d "{ \"user\": \"$PUSHOVER_USER\", \"token\": \"$PUSHOVER_TOKEN\", \"message\": \"$@\" }" \
		"https://api.pushover.net/1/messages.json" &>/dev/null
}