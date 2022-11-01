class VoteUserService < BaseService
  def initialize(user: nil, vote_token: nil, amount: 0)
    @user = user
    @vote_token = vote_token
    @amount = amount

    super()
  end

  def call
    raise ArgumentError if @user.nil? || @vote_token.nil? || @amount.zero?

    trns = @vote_token.tapyrus_token.transfer!(sender: @vote_token.user.glueby_wallet,
                                               receiver_address: @user.glueby_wallet.internal_wallet.receive_address,
                                               amount: @amount)
    votes = []
    @amount.times { votes << Vote.create!(vote_token: @vote_token, user_id: @user.id) }
    @vote_token.update!(amount: 0)

    [trns[1].txid, votes]
  end
end
