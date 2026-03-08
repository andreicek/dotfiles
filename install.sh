#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"
DOTFILES_REPO="https://github.com/andreicek/dotfiles.git"

# Prompt for sudo upfront and keep it alive
sudo -v
while true; do sudo -n true; sleep 55; kill -0 "$$" || exit; done 2>/dev/null &

# --- Clone dotfiles repo if missing ---

if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Cloning dotfiles..."
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
fi
cd "$DOTFILES_DIR"

# --- Bootstrap gum (needed for all TUI output) ---

if ! command -v gum &>/dev/null; then
  echo "Installing gum..."
  GUM_VERSION=$(curl -fsSL https://api.github.com/repos/charmbracelet/gum/releases/latest | grep -oP '"tag_name": "v\K[^"]+')
  curl -fsSL -o /tmp/gum.deb "https://github.com/charmbracelet/gum/releases/download/v${GUM_VERSION}/gum_${GUM_VERSION}_amd64.deb"
  sudo dpkg -i /tmp/gum.deb
fi

# --- TUI helpers ---

info()    { gum log --level info "$*"; }
success() { gum log --level info --prefix "✓" "$*"; }
warn()    { gum log --level warn "$*"; }

TOTAL_STEPS=10
CURRENT_STEP=0
step() {
  CURRENT_STEP=$((CURRENT_STEP + 1))
  echo ""
  gum style --bold --foreground 212 "[$CURRENT_STEP/$TOTAL_STEPS] $*"
}

# --- Styled banner ---

gum style \
  --border double \
  --border-foreground 212 \
  --padding "1 3" \
  --bold \
  "dotfiles installer"

# --- Helpers ---

# Pre-accept Microsoft fonts EULA
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections

apt_updated=false
ensure_apt_updated() {
  if [ "$apt_updated" = false ]; then
    gum spin --title "Updating apt package index..." -- sudo apt-get update -qq
    apt_updated=true
  fi
}

ensure_apt_pkg() {
  local pkg="$1"
  if dpkg -s "$pkg" &>/dev/null; then
    success "$pkg already installed"
  else
    ensure_apt_updated
    gum spin --title "Installing $pkg..." -- sudo apt-get install -y -qq "$pkg"
    success "$pkg installed"
  fi
}

ensure_command() {
  local cmd="$1"
  local install_fn="$2"
  if command -v "$cmd" &>/dev/null; then
    success "$cmd already available"
  else
    info "Installing $cmd..."
    $install_fn
    success "$cmd installed"
  fi
}

# --- [1/10] gum ---

step "gum"
success "gum already available"

# --- [2/10] APT packages ---

step "APT packages"

apt_packages=(
  # Core tools
  git stow zsh curl unzip gnupg2

  # Zsh plugins
  zsh-autosuggestions zsh-syntax-highlighting

  # CLI tools
  bat eza fzf kitty tmux wl-clipboard zoxide

  # Build deps (erlang via mise)
  build-essential libssl-dev libncurses-dev

  # Hyprland ecosystem
  hyprland hyprpaper waybar mako-notifier wofi swaylock
  blueman wireplumber grim slurp swappy pavucontrol cliphist wtype

  # Fonts
  fonts-ibm-plex ttf-mscorefonts-installer fonts-font-awesome

)

for pkg in "${apt_packages[@]}"; do
  ensure_apt_pkg "$pkg"
done

# --- [3/10] Docker ---

step "Docker"
if dpkg -s docker-ce &>/dev/null; then
  success "Docker already installed"
else
  info "Adding Docker repository..."
  sudo install -m 0755 -d /etc/apt/keyrings
  if [ ! -f /etc/apt/keyrings/docker.asc ]; then
    gum spin --title "Downloading Docker GPG key..." -- \
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /tmp/docker.asc
    sudo install -m 0644 /tmp/docker.asc /etc/apt/keyrings/docker.asc
  fi
  if [ ! -f /etc/apt/sources.list.d/docker.list ] && [ ! -f /etc/apt/sources.list.d/docker.sources ]; then
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
  fi
  apt_updated=false
  ensure_apt_updated
  gum spin --title "Installing Docker..." -- \
    sudo apt-get install -y -qq docker-ce docker-ce-cli containerd.io docker-compose-plugin
  sudo usermod -aG docker "$USER"
  success "Docker installed (log out and back in for group membership)"
fi

# --- [4/10] Google Chrome ---

step "Google Chrome"
if dpkg -s google-chrome-stable &>/dev/null; then
  success "Google Chrome already installed"
else
  info "Adding Google Chrome repository..."
  sudo install -m 0755 -d /etc/apt/keyrings
  if [ ! -f /etc/apt/keyrings/google-chrome.asc ]; then
    gum spin --title "Downloading Google Chrome GPG key..." -- \
      curl -fsSL https://dl.google.com/linux/linux_signing_key.pub -o /tmp/google-chrome.asc
    sudo install -m 0644 /tmp/google-chrome.asc /etc/apt/keyrings/google-chrome.asc
  fi
  if [ ! -f /etc/apt/sources.list.d/google-chrome.list ] && [ ! -f /etc/apt/sources.list.d/google-chrome.sources ]; then
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/google-chrome.asc] https://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list >/dev/null
  fi
  apt_updated=false
  ensure_apt_updated
  gum spin --title "Installing Google Chrome..." -- \
    sudo apt-get install -y -qq google-chrome-stable
  success "Google Chrome installed"
fi

# --- [5/10] mise ---

step "mise"
install_mise() {
  gum spin --title "Installing mise..." -- \
    bash -c 'curl -sSfL https://mise.jdx.dev/install.sh | sh'
}
ensure_command "$HOME/.local/bin/mise" install_mise

# --- [6/10] Stow dotfiles ---

step "Stow dotfiles"
cd "$DOTFILES_DIR"
stow --restow git zsh bin nvim kitty tmux mise claude hyprland systemd
success "All packages stowed"

# --- [7/10] Machine profile ---

step "Machine profile"
MACHINE=$(gum choose --header "Select machine profile:" "workstation" "laptop")

ln -sf "machines/${MACHINE}.conf" "$DOTFILES_DIR/hyprland/.config/hypr/machine.conf"
ln -sf "machines/${MACHINE}.hyprpaper.conf" "$DOTFILES_DIR/hyprland/.config/hypr/hyprpaper.conf"
ln -sf "machines/${MACHINE}.jsonc" "$DOTFILES_DIR/hyprland/.config/waybar/config.jsonc"
ln -sf "machines/${MACHINE}" "$DOTFILES_DIR/hyprland/.config/swaylock/config"
success "Machine profile set to $MACHINE"

if [ "$MACHINE" = "laptop" ]; then
  info "Installing laptop-specific packages..."
  ensure_apt_pkg brightnessctl
  ensure_apt_pkg network-manager-gnome
  ensure_apt_pkg wireguard-tools
fi

# --- [8/10] SSH directory ---

step "SSH directory"
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"
success "~/.ssh directory ready"

# --- [9/10] mise runtimes ---

step "mise runtimes"
export PATH="$HOME/.local/bin:$PATH"
gum spin --title "Installing runtimes from mise config (this may take a while)..." -- \
  mise install -y
success "mise runtimes up to date"

# --- [10/10] Default shell ---

step "Default shell"
zsh_path="$(which zsh)"
if [ "$SHELL" = "$zsh_path" ]; then
  success "zsh is already the default shell"
else
  info "Changing default shell to zsh..."
  chsh -s "$zsh_path"
  success "Default shell changed to zsh (takes effect on next login)"
fi

# --- Summary ---

echo ""
gum style \
  --border rounded \
  --border-foreground 77 \
  --padding "1 3" \
  --bold \
  "All done!" \
  "" \
  "Manual steps remaining:" \
  "  - Launch nvim to bootstrap plugins (lazy.nvim auto-installs)"
