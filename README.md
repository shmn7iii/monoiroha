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
$ cat << EOF > .env
TAPYRUS_RPC_SCHEMA=http
TAPYRUS_RPC_HOST=localhost
TAPYRUS_RPC_PORT=12381
TAPYRUS_RPC_USER=rpcuser
TAPYRUS_RPC_PASSWORD=rpcpassword
EOF

# setup script for rails
$ bin/setup

# start server
$ rails server
```

**Migrate**

```bash
# for glueby
$ rails db:migrate

# for others
$ bundle exec rails ridgepole:apply
```

### Docker

```bash
# create containers
$ make docker/up

# start containers
$ make docker/start

# stop containers
$ make docker/stop

# stop and remove containers *ALL VOLUMES REMOVED
$ make docker/down
```

**Migrate**

```bash
$ make rails/migrate
```
