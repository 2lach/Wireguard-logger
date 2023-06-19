# Wireguard-logger
[![CodeFactor](https://www.codefactor.io/repository/github/2lach/wireguard-logger/badge)](https://www.codefactor.io/repository/github/2lach/wireguard-logger)


### it's a tiny logger for wireguard

> Generate persistant logs for your wireguard instance(s)

## Highlights

> Deploy on your wireguard server and get not 1, not 2 but 3 logging options 


### Installation
*_Step 1_*
```sh
# Clone repo (to any location)
git clone https://github.com/2lach/Wireguard-logger.git
cd Wireguard-logger
```

*_Step 2_*
```sh
# save the path as a temporary env var
WG_LOGGER_PATH=$(realpath wg-logger.sh)
```

*_Step 3_*
```bash
# add it to your root bashrc
printf "\n# wg-logger \nsource $WG_LOGGER_PATH &" | sudo tee -a /root/.bashrc
```

*_Step 4_*
```bash
# verify succes with
sudo cat /root/.bashrc
```

*_Step 5_*
```text
enable logging

first you decide the type of logging you want to enable.
You do this by first reading the specifications in # logging modes # section of `wg-logger.sh`

then you uncomment or add the function name of you logging
of your choice in the # Start logging  # section of `wg-logger.sh`
```

*_Step 6_*
```bash
# activation

# log in as sudo user
sudo su
# this will initalize Wireguard-logger and should generate output similiar to this:
tcpdump: found
/var/log/wireguard exist.
Starting up wireguard-logger
```

*_Quickstart_*
```bash
or you can just start it with
sudo bash ./wg-logger.sh &
# you will still need to do Step 5 for this to work
```

this project requires [tcpdump](https://www.tcpdump.org/index.html#latest-releases)
_setup with debian/ubuntu_
```bash
sudo apt install tcpdump
```
_setup with osx (homebrew)_
```bash
brew install tcpdump
```
## About
it needs to run as a sudo user or with sudo cmd
1) because the standard path for wireguard log files goes in /var/log/ folder (this can be changed)
2) tcpdump need to run as sudo to get access to network information
3) you need to enable the type of logging you want to use. Do this by uncommenting your selection in [wg-logger.sh](./wg-logger.sh) in the  "Start logging" section, or else the logging will not be enabled
4) if you change where you keep this repo on your disk the path to `/root/.bashrc` will be broken and you will need to re-do the installation (step 2 - 4) and remove the old "source path" 
## Compatability
- The script is tested and works works with bash and linux
- should likely work on any unix-ish enviroment, but that is speculation and not fact

## Maintainer & Creator

- [Stefan Lachmann](https://github.com/2lach)

## License

MIT

