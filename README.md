# Wireguard-logger
### it's a tiny logger for wireguard

> Generate persistant logs for your wireguard instance(s)

## Highlights

> Deploy on your wireguard server and get not 1, not 2 but 3 logging options 


### Installation
```sh
# Clone repo
git clone https://github.com/2lach/Wireguard-logger.git
cd Wireguard-logger
```

```sh
# add it to your root bashrc
sudo printf '# wg-logger \n
source $PWD/wg-logger.sh &' >> /root/.bashrc
```

or you can just start it with
```sh
sudo bash ./wg-logger.sh &
```

this project requires [tcpdump](https://www.tcpdump.org/index.html#latest-releases)

## Notes
- The script is tested and works works with bash and linux
- should likely work on any unix-ish enviroment, but that is speculation

## Notes

## Maintainer & Creator

- [Stefan Lachmann](https://github.com/2lach)

## License

MIT

