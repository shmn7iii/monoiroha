# monoiroha

> **B3 - Blockchain Boot Camp & Business Plan Contest -** 参加作品
>
> 「DAOを用いたハンドメイドマーケットプレイス『monoiroha』」

<div align="center">
  <img src="doc/B3パネル.png"　title="B3パネル">
</div>

## Specification

- Ruby 3.1.2
- Rails 7.0.4

## Development

### Setup

> **Note**
> If you use the default Tapyrus Genesis Block described in compose.yaml, the auht-key is cUJN5RVzYWFoeY8rUztd47jzXCu1p57Ay8V7pqCzsBD3PEXN7Dd4. For actual use, please generate your own the Tapyrus Genesis Block and use the auth-key that you used.

```bash
# set .env
$ cat << EOF > .env
TAPYRUS_RPC_SCHEMA=http
TAPYRUS_RPC_HOST=tapyrusd
TAPYRUS_RPC_PORT=12381
TAPYRUS_RPC_USER=rpcuser
TAPYRUS_RPC_PASSWORD=rpcpassword
AUTHORITY_KEY=<auth-key>
BASIC_AUTH_USER=<user>
BASIC_AUTH_PASSWORD=<pass>
EOF

# create containers and run bin/setup
$ make docker/up
```

### Make commands

```bash
# create containers and run bin/setup
$ make docker/up

# start containers
$ make docker/start

# stop containers
$ make docker/stop

# stop and remove containers *ALL VOLUMES REMOVED
$ make docker/down

# migrate
$ make rails/migrate

# run rails console
$ make rails/console

# reset rails database
$ make rails/reset
```

## Deployment

```bash
# install dependency
$ sudo apt install curl git make

# install docker
$ curl -fsSL https://get.docker.com -o get-docker.sh
$ sudo sh get-docker.sh

# clone
$ git clone https://github.com/shmn7iii/monoiroha.git

# set .env
$ cat << EOF > .env
RAILS_ENV=production
TAPYRUS_RPC_SCHEMA=http
TAPYRUS_RPC_HOST=tapyrusd
TAPYRUS_RPC_PORT=12381
TAPYRUS_RPC_USER=rpcuser
TAPYRUS_RPC_PASSWORD=rpcpassword
AUTHORITY_KEY=<auth-key>
BASIC_AUTH_USER=<user>
BASIC_AUTH_PASSWORD=<pass>
EOF

# upload master.key
[local]$ cd ./config
[local]$ sftp monoiroha
Connected to monoiroha.
sftp> cd monoiroha/config
sftp> put master.key
Uploading master.key to /home/ubuntu/monoiroha/config/master.key
master.key                                                                                                          100%   32     1.1KB/s   00:00

# setup container
$ sudo make prod/docker/setup

# setup systemd
$ sudo cp monoiroha.service /etc/systemd/system/monoiroha.service
$ sudo systemctl enable --now monoiroha
```
