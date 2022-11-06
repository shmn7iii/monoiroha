class UsersController < ApplicationController
  def index
    @users = User.where.not(id: 1)
  end

  def vote
    voter = User.find(1) # XXX: 固定
    user = User.find(params[:id])

    VoteUserService.call(user:,
                         vote_token: vote_token = voter.active_vote_token, # XXX: 固定
                         amount: vote_token&.amount || 0) # XXX: 固定
    @address = voter.glueby_wallet.internal_wallet.receive_address
    flash[:error] = 'Success!'
    redirect_to users_path
  rescue ArgumentError
    flash[:danger] = 'Error!'
    redirect_to users_path
  end
end
