# Dotfiles dengan Dual Prompt Theme

Dotfiles ini menggunakan [chezmoi](https://www.chezmoi.io) untuk manajemen konfigurasi dan mendukung dua tema prompt:
- Powerlevel10k (dengan dua style: minimal dan neon)
- Spaceship

## Instalasi

1. Install chezmoi:
```bash
sh -c "$(curl -fsLS get.chezmoi.io)"
```

2. Clone dan apply dotfiles:
```bash
chezmoi init github.com/yourusername/dotfiles2 --apply
```

## Beralih Prompt Theme

Untuk beralih antara Powerlevel10k dan Spaceship prompt:

```bash
# Beralih ke Powerlevel10k dengan style minimal
chezmoi data --modify --prompt_theme powerlevel10k --p10k_style minimal
chezmoi apply

# Beralih ke Powerlevel10k dengan style neon
chezmoi data --modify --prompt_theme powerlevel10k --p10k_style neon
chezmoi apply

# Beralih ke Spaceship
chezmoi data --modify --prompt_theme spaceship
chezmoi apply
```

Atau gunakan script yang disediakan:
```bash
# Beralih ke Powerlevel10k dengan style minimal
./scripts/switch-prompt.sh p10k minimal

# Beralih ke Powerlevel10k dengan style neon
./scripts/switch-prompt.sh p10k neon

# Beralih ke Spaceship
./scripts/switch-prompt.sh spaceship
```

## Fitur

- Dual prompt theme:
  - Powerlevel10k dengan dua style (minimal dan neon)
  - Spaceship
- Oh My Zsh
- Plugin berguna (zsh-autosuggestions, zsh-syntax-highlighting, fzf)
- Alias yang berguna
- Konfigurasi Git
- Dan banyak lagi!

## Struktur Folder

```
dotfiles2/
├── .chezmoi.toml           # Konfigurasi chezmoi
├── README.md
├── config/
│   ├── zsh/
│   │   ├── powerlevel10k/  # Konfigurasi Powerlevel10k
│   │   │   ├── p10k.minimal.zsh
│   │   │   └── p10k.neon.zsh
│   │   └── spaceship/      # Konfigurasi Spaceship
│   └── bin/
├── templates/
│   ├── dot_zshrc.tmpl      # Template .zshrc
│   └── dot_prompt.tmpl     # Template prompt
└── scripts/
    └── switch-prompt.sh    # Script untuk beralih prompt
``` 