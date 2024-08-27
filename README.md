### Build

```bash
docker build -t gtnh-server:2.6.0 .
```

### Run

```bash
mkdir world backups
# make sure owner of ./world and ./backups is 1000:1000 when mounded

docker run -it --rm --name gtnh -v $(pwd)/world:/server/World -v $(pwd)/backups:/server/backups gtnh-server:2.6.0
```

### Execute commands

```bash
docker attach gtnh
> whitelist add Her0br1ne
> whitelist reload
```
