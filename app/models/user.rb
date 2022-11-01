class User < ApplicationRecord
  belongs_to :wallet
  has_many :items
  has_many :vote_tokens
  has_many :votes

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
  def number_of_votes
    votes.size
  end
  
  # おすすめ商品
  def show_pick_up
    users = []
    self.each do |user|
      users.push user.number_of_votes
    end
    return users
  end
end
