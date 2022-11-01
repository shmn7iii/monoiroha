class SearchTransactionService < BaseService
  def initialize(id:, user: nil)
    @user = user
    @id = id

    super()
  end

  def call
    raise ArgumentError if @user.nil? || @id.nil?

    wallet = @user.glueby_wallet
    txid = if @id.start_with?('c1', 'c2', 'c3')
             wallet.internal_wallet.list_unspent.find { |lu| lu[:color_id] == @id } [:txid]
           else
             @id
           end

    Tapyrus::Tx.parse_from_payload(Glueby::Internal::RPC.client.getrawtransaction(txid.to_s).htb)
  end
end
