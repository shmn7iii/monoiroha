class VotesController < ApplicationController
  after_action :generate_block, only: %i[create]

  def progress
    @votee_id = params[:votee_id]
  end

  def create
    voter = User.find(1) # XXX: 固定
    votee = User.find(params[:votee_id])

    @vote = VoteUserService.call(votee:, voter:,
                                 vote_token: vote_token = voter.active_vote_token, # XXX: 固定
                                 amount: vote_token&.amount || 0) # XXX: 固定

    @address = voter.glueby_wallet.internal_wallet.receive_address

    redirect_to votes_complete_path(vote_id: @vote.id)
  rescue StandardError
    flash[:danger] = 'Error!'
    redirect_to users_path
  end

  def complete
    @vote = Vote.find(params[:vote_id])
  end
end
