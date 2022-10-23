class UsersController < ApplicationController
  after_action :generate_block, only: %i[vote]

  def index
    @users = User.all
  end

  def vote
    voter = User.find(1) # XXX: 固定
    voter_wallet = Glueby::Wallet.load(voter.wallet.id)
    user = User.find(params[:id])
    user_wallet = Glueby::Wallet.load(user.wallet.id)

    vote_token = User.find(1).vote_tokens.find_by(amount: 1..) # XXX: 昇順で固定
    amount = vote_token.amount # XXX: 最大値で固定

    color_id = Tapyrus::Color::ColorIdentifier.parse_from_payload(vote_token.token_id.htb)
    token = Glueby::Contract::Token.new(color_id:)
    receiver_address = user_wallet.internal_wallet.receive_address

    token.transfer!(sender: voter_wallet,
                    receiver_address:,
                    amount:)

    # 投票数分　Vote　レコード作成
    amount.times do
      Vote.create!(vote_token:, user_id: user.id)
    end

    vote_token.update!(amount: 0)

    @address = voter_wallet.internal_wallet.receive_address
    flash[:success] = 'Success!'
    redirect_to users_path
  end

  private

  def generate_block
    Glueby::Internal::RPC.client.generatetoaddress(1, @address, ENV['AUTHORITY_KEY'])
    `rails glueby:block_syncer:start`
  end
end
