Tapyrus.chain_params = :dev
Glueby.configure do |config|
  config.wallet_adapter = :activerecord
  config.rpc_config = { schema: ENV['TAPYRUS_RPC_SCHEMA'],
                        host: ENV['TAPYRUS_RPC_HOST'],
                        port: ENV['TAPYRUS_RPC_PORT'],
                        user: ENV['TAPYRUS_RPC_USER'],
                        password: ENV['TAPYRUS_RPC_PASSWORD'] }
end
