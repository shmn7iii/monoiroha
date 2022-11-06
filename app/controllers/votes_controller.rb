class VotesController < ApplicationController
  after_action :generate_block, only: %i[create]

  def progress
    @votee_id = params[:votee_id]
  end

  def create
    voter = User.find(1) # XXX: 固定
    votee = User.find(params[:votee_id])

    vote = VoteUserService.call(votee:, voter:,
                                vote_token: vote_token = voter.active_vote_token, # XXX: 固定
                                amount: vote_token&.amount || 0) # XXX: 固定

    @address = voter.glueby_wallet.internal_wallet.receive_address

    # 本番環境用リダイレクト
    if Rails.env.production?
      redirect_to "https://monoiroha.shmn7iii.net/votes/complete?vote_id=#{vote.id}", allow_other_host: true
    else
      redirect_to votes_complete_path(vote_id: vote.id)
    end
  rescue StandardError
    flash[:danger] = 'Error!'
    if Rails.env.production?
      redirect_to 'https://monoiroha.shmn7iii.net/users', allow_other_host: true
    else
      redirect_to users_path
    end
  end

  def complete
    @vote = Vote.find(params[:vote_id])
  end
end
