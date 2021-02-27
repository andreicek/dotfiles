function notify() {
	osascript -e "display notification \"$1\" with title \"Notify\""
}

function push() {
	curl -X POST \
		-H "content-type: application/json" \
		-d "{ \"user\": \"$PUSHOVER_USER\", \"token\": \"$PUSHOVER_TOKEN\", \"message\": \"$@\" }" \
		"https://api.pushover.net/1/messages.json" &>/dev/null
}

function cdtemp() {
	local temp=$(mktemp -d)
	echo "pushd $temp"
	pushd $temp
}

function backup() {
	borgmatic --config ~/.dotfiles/borgmatic.yaml -v 1
}
