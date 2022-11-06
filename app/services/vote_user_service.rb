class VoteUserService < BaseService
  def initialize(votee: nil, voter: nil, vote_token: nil, amount: 0)
    @votee = votee
    @voter = voter
    @vote_token = vote_token
    @amount = amount

    super()
  end

  def call
    raise ArgumentError if @votee.nil? || @voter.nil? || @vote_token.nil? || @amount.zero?

    trnsfr = @vote_token.tapyrus_token.transfer!(sender: @voter.glueby_wallet,
                                                 receiver_address: @votee.glueby_wallet.internal_wallet.receive_address,
                                                 amount: @amount)

    vote = Vote.create!(votee: @votee, voter: @voter, vote_token: @vote_token, amount: @amount, txid: trnsfr[1].txid)
    @vote_token.update!(amount: 0)

    vote
  end
end
