class UsersController < ApplicationController
  after_action :generate_block, only: %i[vote]

  def index
    @users = User.all
  end

  def vote
    voter = User.find(1) # XXX: 固定
    user = User.find(params[:id])
    vote_token = voter.active_vote_token # XXX: 固定
    amount = vote_token&.amount || 0 # XXX: 固定

    # ほんとはキーワード引数にしたい
    VoteUserService.call(user, vote_token, amount)

    @address = voter.glueby_wallet.internal_wallet.receive_address
    flash[:error] = 'Success!'
    redirect_to users_path
  rescue ArgumentError
    flash[:danger] = 'Error!'
    redirect_to users_path
  end
end
