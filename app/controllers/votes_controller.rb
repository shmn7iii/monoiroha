class VotesController < ApplicationController
  after_action :generate_block, only: %i[create]

  def progress
    @user_id = params[:user_id]
  end

  def create
    voter = User.find(1) # XXX: 固定
    user = User.find(params[:user_id])

    vote = VoteUserService.call(user:,
                                vote_token: vote_token = voter.active_vote_token, # XXX: 固定
                                amount: vote_token&.amount || 0) # XXX: 固定

    @address = voter.glueby_wallet.internal_wallet.receive_address
    flash[:success] = 'Success!'
    redirect_to votes_complete_path(first_vote_id: vote[1][0].id, txid: vote[0], vote_amount: vote[1].size)
  rescue ArgumentError
    flash[:danger] = 'Error!'
    redirect_to users_path
  end

  def complete
    @txid = params[:txid]
    @first_vote = Vote.find(params[:first_vote_id])
    @vote_amount = params[:vote_amount]
  end
end
