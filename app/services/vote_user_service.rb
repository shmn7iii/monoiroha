class VoteUserService < BaseService
  def initialize(user, vote_token, amount)
    @user = user
    @vote_token = vote_token
    @amount = amount
  end

  def call
    raise ArgumentError, "missing vote-token" if @vote_token.nil? || @amount.zero?

    @vote_token.tapyrus_token.transfer!(sender: @vote_token.user.glueby_wallet, receiver_address: @user.glueby_wallet.internal_wallet.receive_address, amount: @amount)
    @amount.times { Vote.create!(vote_token: @vote_token, user_id: @user.id) }
    @vote_token.update!(amount: 0)
  end
end
