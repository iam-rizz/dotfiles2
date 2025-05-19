#!/bin/bash

# Zsh Dotfiles + Optional Debian Upgrade Installer
set -euo pipefail

# Warna
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

print_status()    { echo -e "${CYAN}${BOLD}[INFO]${NC} $1"; }
print_success()   { echo -e "${GREEN}${BOLD}[SUCCESS]${NC} $1"; }
print_error()     { echo -e "${RED}${BOLD}[ERROR]${NC} $1"; }
print_warning()   { echo -e "${YELLOW}${BOLD}[WARNING]${NC} $1"; }

install_if_missing() {
    if ! command -v "$1" &>/dev/null; then
        print_status "Installing $1..."
        sudo apt-get update -qq
        sudo apt-get install -y "$1"
    fi
}

get_debian_version() {
    grep -oP '(?<=VERSION_ID=")(\d+)' /etc/os-release
}

upgrade_debian_to_13() {
    install_if_missing vnstat
    local ver
    ver=$(get_debian_version)
    if [[ "$ver" != "12" ]]; then
        print_error "Upgrade hanya didukung dari Debian 12. Saat ini: Debian $ver"
        exit 1
    fi

    print_status "Backup /etc/apt/sources.list ke sources.list.bak..."
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak

    print_status "Menulis ulang sources.list untuk Debian 13 (trixie)..."
    cat <<EOF | sudo tee /etc/apt/sources.list >/dev/null
deb http://deb.debian.org/debian/ trixie main non-free-firmware
deb-src http://deb.debian.org/debian/ trixie main non-free-firmware

deb http://security.debian.org/debian-security trixie-security main non-free-firmware
deb-src http://security.debian.org/debian-security trixie-security main non-free-firmware

deb http://deb.debian.org/debian/ trixie-updates main non-free-firmware
deb-src http://deb.debian.org/debian/ trixie-updates main non-free-firmware
EOF

    print_status "Update dan upgrade sistem..."
    sudo apt update && sudo apt upgrade -y
    sudo apt full-upgrade -y
    sudo apt dist-upgrade -y

    print_success "Upgrade ke Debian 13 selesai! Disarankan untuk reboot."
    exit 0
}

install_dotfiles() {
    print_status "Menginstal dependensi dasar..."
    for pkg in curl wget git zsh fzf lsd bat docker.io vnstat; do
        install_if_missing "$pkg"
    done

    # Install zoxide
    if ! command -v zoxide &>/dev/null; then
        print_status "Menginstal zoxide..."
        curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    fi

    # Install Oh My Zsh
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        print_status "Menginstal Oh My Zsh..."
        export RUNZSH=no
        export CHSH=no
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi

    # Install powerlevel10k theme
    P10K_DIR="$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
    if [[ ! -d "$P10K_DIR" ]]; then
        print_status "Menginstal Powerlevel10k..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
    fi

    # Install spaceship theme
    SPACESHIP_DIR="$HOME/.oh-my-zsh/custom/themes/spaceship-prompt"
    if [[ ! -d "$SPACESHIP_DIR" ]]; then
        print_status "Menginstal Spaceship Prompt..."
        git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$SPACESHIP_DIR" --depth=1
        ln -sf "$SPACESHIP_DIR/spaceship.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/spaceship.zsh-theme"
    fi

    # Plugin tambahan
    ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
    [[ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]] || \
        git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
    [[ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]] || \
        git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

    # Install chezmoi
    if ! command -v chezmoi &>/dev/null; then
        print_status "Menginstal chezmoi..."
        sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
        export PATH="$HOME/.local/bin:$PATH"
    fi

    # Tambahkan ke PATH & link global jika perlu
    [[ -f /usr/local/bin/chezmoi ]] || sudo ln -sf "$HOME/.local/bin/chezmoi" /usr/local/bin/chezmoi

    print_status "Inisialisasi dotfiles via chezmoi..."
    chezmoi init github.com/iam-rizz/dotfiles2

    print_status "Mengatur config chezmoi..."
    mkdir -p "$HOME/.config/chezmoi"
    ln -sf "$HOME/.local/share/chezmoi/.chezmoi.toml" "$HOME/.config/chezmoi/chezmoi.toml"

    print_status "Menerapkan dotfiles..."
    chezmoi apply

    print_status "Mengatur Zsh sebagai shell default..."
    chsh -s "$(which zsh)"

    clear
    echo -e "\n${CYAN}${BOLD}======================================================${NC}"
    echo -e "${GREEN}${BOLD}    🔧 Dotfiles Anda sekarang dikelola oleh chezmoi     ${NC}"
    echo -e "${CYAN}${BOLD}======================================================${NC}"

    echo -e "${BOLD}📁 GitHub Repo: ${NC}https://github.com/iam-rizz/dotfiles2\n"
    echo -e "${BOLD}Perintah chezmoi berguna:${NC}"
    echo -e "  ${YELLOW}chezmoi edit ~/.zshrc${NC}        # Edit file dotfiles"
    echo -e "  ${YELLOW}chezmoi apply${NC}                # Terapkan perubahan lokal"
    echo -e "  ${YELLOW}chezmoi add ~/.bash_aliases${NC}  # Tambahkan file baru"
    echo -e "  ${YELLOW}chezmoi cd${NC}                   # Masuk ke direktori repo"
    echo -e "  ${YELLOW}chezmoi status${NC}               # Lihat perubahan"
    echo -e "\n${BOLD}Perintah switch prompt:${NC}"
    echo -e "  ${YELLOW}switch-prompt p10k minimal${NC}   # Switch ke Powerlevel10k minimal"
    echo -e "  ${YELLOW}switch-prompt p10k neon${NC}      # Switch ke Powerlevel10k neon"
    echo -e "  ${YELLOW}switch-prompt spaceship${NC}      # Switch ke Spaceship prompt"
    echo -e "\n${GREEN}${BOLD}Silakan pelajari dan kelola dotfiles Anda langsung dari GitHub.${NC}"
    sleep 2
    exec zsh
}

# Menu utama
echo -e "${CYAN}${BOLD}======================================================${NC}"
echo -e "${CYAN}${BOLD}         RIZZ INSTALLER — DOTFILES & DEBIAN          ${NC}"
echo -e "${CYAN}${BOLD}======================================================${NC}"

echo -e "\nPilih aksi:"
echo "1) Upgrade ke Debian 13 (trixie)"
echo "2) Install Zsh + Dotfiles via chezmoi"
echo "3) Keluar"
read -rp "Masukkan pilihan [1/2/3]: " choice

case "$choice" in
    1) upgrade_debian_to_13 ;;
    2) install_dotfiles ;;
    3) print_status "Keluar." && exit 0 ;;
    *) print_error "Pilihan tidak valid." && exit 1 ;;
esac
