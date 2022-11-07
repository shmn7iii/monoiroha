# monoiroha

## Specification

- Ruby 3.1.2
- Rails 7.0.4

## Development

### Local

**Setup**

```bash
# create tapyrusd container
$ docker run -d --name 'tapyrus_node_dev' -p 12381:12381 -e GENESIS_BLOCK_WITH_SIG='0100000000000000000000000000000000000000000000000000000000000000000000002b5331139c6bc8646bb4e5737c51378133f70b9712b75548cb3c05f9188670e7440d295e7300c5640730c4634402a3e66fb5d921f76b48d8972a484cc0361e66ef74f45e012103af80b90d25145da28c583359beb47b21796b2fe1a23c1511e443e7a64dfdb27d40e05f064662d6b9acf65ae416379d82e11a9b78cdeb3a316d1057cd2780e3727f70a61f901d10acbe349cd11e04aa6b4351e782c44670aefbe138e99a5ce75ace01010000000100000000000000000000000000000000000000000000000000000000000000000000000000ffffffff0100f2052a010000001976a91445d405b9ed450fec89044f9b7a99a4ef6fe2cd3f88ac00000000' tapyrus/tapyrusd:v0.5.1

# set .env
# if you use default tapyrusd container, auth-key is 'cUJN5RVzYWFoeY8rUztd47jzXCu1p57Ay8V7pqCzsBD3PEXN7Dd4'
$ cat << EOF > .env
TAPYRUS_RPC_SCHEMA=http
TAPYRUS_RPC_HOST=localhost
TAPYRUS_RPC_PORT=12381
TAPYRUS_RPC_USER=rpcuser
TAPYRUS_RPC_PASSWORD=rpcpassword
AUTHORITY_KEY=<auth-key>
BASIC_AUTH_USER=<user>
BASIC_AUTH_PASSWORD=<pass>
EOF

# setup script for rails
$ bin/setup

# start server
$ bin/rails server
```

**Migrate**

```bash
# for glueby
$ bin/rails db:migrate

# for others
$ bin/bundle exec bin/rails ridgepole:apply
```

### Docker

**Setup**

```bash
# set .env
# if you use default tapyrusd container, auth-key is 'cUJN5RVzYWFoeY8rUztd47jzXCu1p57Ay8V7pqCzsBD3PEXN7Dd4'
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

**Make commands**

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
# if you use default tapyrusd container, auth-key is 'cUJN5RVzYWFoeY8rUztd47jzXCu1p57Ay8V7pqCzsBD3PEXN7Dd4'
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
$ sftp monoiroha
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
