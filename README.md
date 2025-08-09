<h1 align="center">
	✨ Polaroid-Dotfiles ✨
    </br></br>
<p align="center">
  <img src="https://img.shields.io/badge/made%20with-bash-blue?style=for-the-badge&logo=gnubash">
  <img src="https://img.shields.io/badge/ubuntu-24.04%20LTS-E95420?style=for-the-badge&logo=ubuntu&logoColor=white">
  <img src="https://img.shields.io/github/license/Pol4rLun4r/polaroid-dotfiles?style=for-the-badge">
</p>
    <img src=".github/overview.png">
</h1>

<div align = center>

&ensp;[<kbd> <br> Instalação <br> </kbd>](#-instalação)&ensp;
&ensp;[<kbd> <br> Funcionalidades <br> </kbd>](#-funcionalidades-principais)&ensp;
&ensp;[<kbd> <br> Reversão <br> </kbd>](#-funcionalidades-de-reversão)&ensp;

</div>

## 📝 Motivação

Este projeto é fruto do meu primeiro contato prático com Linux. Há cerca de 6 meses, iniciei minha jornada buscando um sistema operacional mais alinhado aos meus estudos em desenvolvimento web e programação em geral. Com o tempo, fui me aprofundando no ecossistema Linux e acabei me apaixonando pela flexibilidade, filosofia open source e pela comunidade vibrante.

Ao conhecer comunidades como a r/LinuxPorn, surgiu a vontade de personalizar ainda mais meu ambiente — no caso, o Ubuntu — para deixá-lo com a minha identidade visual. Durante esse processo, aprendi muito sobre Bash, automação e scripts de pós-instalação. O polaroid-dotfiles nasceu dessa necessidade: evitar retrabalho após reinstalações, mantendo minha estética e ferramentas favoritas com poucos comandos.

Tenho consciência de que o projeto tem limitações — como o foco exclusivo no Ubuntu 24.04 LTS com Wayland —, mas ele representa meu primeiro passo concreto na criação de soluções automatizadas para o desktop Linux. E acredito que ainda há muito mais por vir.

## 📖 O que é?

`polaroid-dotfiles` é um conjunto de scripts interativos que automatizam a configuração do seu ambiente **Ubuntu 24.04 LTS**, com foco em personalização visual e instalação de ferramentas de uso frequente. A ideia é reduzir o trabalho manual após formatações, proporcionando um setup rápido e padronizado.

## 🚀 Funcionalidades Principais
- [x] **Atalho global**: Ao usar o script pela primeira vez, um atalho global(`polar-dot`) será criado para facilitar os próximos usos.
- [x] **Instalação Modular via Menu**: Interface de terminal que guia o usuário na escolha das tarefas.
- [x] **Personalização Gruvbox**: Wallpapers, tema e ícones inspirados no estilo Gruvbox.
    - [Wallpapers](https://gruvbox-wallpapers.pages.dev/)
    - [Ícones](https://www.gnome-look.org/p/1961046)
- [x] **Extensões GNOME**: Baixa e instala as seguintes extensões
    - [ArchMenu](https://extensions.gnome.org/extension/3628/arcmenu/)
    - [Blur my Shell](https://extensions.gnome.org/extension/3193/blur-my-shell/)
    - [Color Picker](https://extensions.gnome.org/extension/3396/color-picker/)
    - [Dash to Dock](https://extensions.gnome.org/extension/307/dash-to-dock/)
    - [GSConnect](https://extensions.gnome.org/extension/1319/gsconnect/)
    - [Just Perfection](https://extensions.gnome.org/extension/3843/just-perfection/)
    - [Media Controls](https://extensions.gnome.org/extension/4470/media-controls/)
    - [Open Bar](https://extensions.gnome.org/extension/6580/open-bar/)
    - [Removable Drive Menu](https://extensions.gnome.org/extension/7/removable-drive-menu/)
    - [System Monitor](https://extensions.gnome.org/extension/6807/system-monitor/)
    - [Top Bar Organizer](https://extensions.gnome.org/extension/4356/top-bar-organizer/)
    - [User Themes](https://extensions.gnome.org/extension/19/user-themes/)
    - [Wallpaper Slideshow](https://extensions.gnome.org/extension/6281/wallpaper-slideshow/)
- [x] **Instalação de Programas**: Baixa e instala aplicativos de uso diário, sendo eles os seguintes
    - [Spotify](https://flathub.org/apps/com.spotify.Client)
    - [Obsidian](https://flathub.org/apps/md.obsidian.Obsidian)
    - [MusicPod](https://flathub.org/apps/org.feichtmeier.Musicpod)
    - [FreeTube](https://flathub.org/apps/search?q=freetube)
    - [zapzap](https://flathub.org/apps/com.rtosta.zapzap)
    - [Vesktop](https://flathub.org/apps/dev.vencord.Vesktop)
    - [AudioRelay](https://flathub.org/apps/net.audiorelay.AudioRelay)
    - [ExtensionManager](https://flathub.org/apps/com.mattjakeman.ExtensionManager)
    - [Telegram](https://snapcraft.io/telegram-desktop)
    - [Thunderbird](https://snapcraft.io/thunderbird)
    - [VSCode](https://snapcraft.io/code)
    - [Motrix](https://snapcraft.io/motrix)
    - [Dialect](https://snapcraft.io/dialect)
    - [ChatGPT](https://snapcraft.io/chatgpt-desktop-client)

- [x] **Mensagens de Confirmação**: Prompt antes de downloads, reinstalações ou alterações críticas.

## 🔄 Funcionalidades de Reversão

Caso queira desfazer alterações, há opções de remoção:

- [x] **Apagar Tema Gruvbox** (ícones e cores)
- [x] **Apagar Wallpapers Gruvbox**
- [x] **Apagar Extensões GNOME**

> Não há script para desinstalar programas, pois essa parte exige decisões manuais do usuário.

## ⚙️ Pré-requisitos

- **Sistema**: Ubuntu 24.04 LTS (Wayland)
    
- **Permissões**: Acesso a `sudo`
    
- **Local de Instalação**: Pasta `~/polaroid-dotfiles`
    
- **Conexão com Internet**
    

## 💾 Instalação

1. No diretório Home (`~`), clone o repositório e ajuste permissões:
    
    ```
    cd ~
    git clone https://github.com/Pol4rLun4r/polaroid-dotfiles.git
    cd polaroid-dotfiles
    chmod +x main.sh
    ```
    
2. Execute o script principal:
    
    ```
    ./main.sh
    ```
    
3. **Reinício de Sessão**: Devido a limitações do Wayland, algumas tarefas (especialmente extensões GNOME) exigem reiniciar a sessão. O script indicará quando for necessário.

## 🎛️ Uso Interativo

Ao executar `./main.sh` ou `polar-dot`(após o primeiro uso do script), o **Menu Principal** apresenta as opções:
<img src=".github/main.png"/>

- **Confirmações**: Antes de cada ação, são exibidos prompts como:
<img src=".github/confirm-exemple1.png">
    ou
<img src=".github/confirm-exemple2.png">

Esses avisos evitam ações não intencionais e mantêm o controle do usuário.

## 🔍 Exemplos de Fluxo

1. Escolher **(1) Instalações Principais[...]** → confirmar **(y)** → entra no submenu
    
2. Escolher **(1)** para entrar no submenu das instalações → **(4) Baixar e Aplicar Tema e Ícones** → reiniciar sessão
    
3. Escolher **(2) Reverter Configurações** → selecionar ação desejada
    

## 🛠️ Futuras Funcionalidades

**As próximas melhorias planejadas incluem:**
    
- [ ] **Instalações secundárias**:
    
    - [ ] **Zsh e plugins**: Script para instalar Zsh e plugins populares (ex: oh-my-zsh, powerlevel10k).
    - [ ] **Terminal alternativo**: Instalação e configuração de um terminal como Alacritty.
    - [ ] **Fontes para Zsh**: Instalar fontes Nerd Fonts ou compatíveis para exibição de ícones.
    - [ ] **Fastfetch**: Script para instalar o Fastfetch.
    - [ ] **Alterar Ícone**: Ferramenta para alterar ícones dos apps que foram baixados através de pacotes Snap ou Flatpak.


## 🤝 Contribuição

Contribuições são bem-vindas:

1. Fork este repositório
    
2. Crie uma branch de feature (`git checkout -b feature/descricao`)
    
3. Faça commits com emojis seguindo o padrão do projeto
    
4. Abra um Pull Request
    

## 📄 Licença

Licenciado sob a MIT [License](LICENSE).