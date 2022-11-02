class Vote < ApplicationRecord
  belongs_to :votee, class_name: 'User'
  belongs_to :voter, class_name: 'User'

  belongs_to :vote_token

  validates :amount, presence: true, numericality: { only_integer: true }
  validates :txid, presence: true

  def votee
    User.find(votee_id)
  end

  def voter
    User.find(voter_id)
  end
end
