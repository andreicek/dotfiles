function notify() {
  powershell.exe -command New-BurntToastNotification -Text "$1"
}