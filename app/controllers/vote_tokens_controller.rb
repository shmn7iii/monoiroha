class VoteTokensController < ApplicationController
  def index
    @active_vote_tokens_amount = User.find(1).active_vote_tokens_amount # XXX: 固定
    @active_vote_tokens = User.find(1).active_vote_tokens # XXX: 固定
  end
end
