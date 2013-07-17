mint-lamp
=========

This script provides a semi-automatic lamp installation. It is nearly a one-to-one copy of this post:

http://community.linuxmint.com/tutorial/view/486

Most of the commands will run without user interaction.

Keywords: lamp, linux, mint, ubuntu, php, apache, mysql, phpmyadmin

Tested with: Ubuntu Server 12.04 LTS x64, Linux Mint 15 x64

Installation
============

Quick version:

```
wget -q -O- https://raw.github.com/mcpacosy/mint-lamp/master/install_lamp.sh | bash
```

Alternative version:

```
wget https://raw.github.com/mcpacosy/mint-lamp/master/install_lamp.sh
chmod +x install_lamp.sh
./install_lamp.sh
```