class User < ApplicationRecord
  belongs_to :wallet
  has_many :items
  has_many :vote_tokens
  has_many :votes, class_name: 'Vote', foreign_key: 'voter_id'
  has_many :voteds, class_name: 'Vote', foreign_key: 'votee_id'

  validates :name, presence: true, length: { maximum: 255 }

  def glueby_wallet
    Glueby::Wallet.load(wallet_id)
  end

  # XXX: 固定
  def active_vote_token
    vote_tokens.find_by(amount: 1..)
  end

  def active_vote_tokens
    vote_tokens.where(amount: 1..)
  end

  # 所持投票可能票数
  def active_vote_tokens_amount
    vote_tokens.pluck(:amount).sum
  end

  # 得票数
  def number_of_voteds
    voteds.pluck(:amount).sum
  end

  # 投票が多い順
  def self.order_voted
    includes(:voteds).sort { |a, b| b.voteds.sum(:amount) <=> a.voteds.sum(:amount) }
  end
end
