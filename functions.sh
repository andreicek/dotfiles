function notify() {
  powershell.exe -command New-BurntToastNotification \
    -AppLogo "\"C:\\Users\\andre\\Pictures\\suse.png\"" \
    -Text "\"$@\""
}