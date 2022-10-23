class User < ApplicationRecord
  belongs_to :wallet
  has_many :items
  has_many :vote_tokens
  has_many :votes

  validates :name, presence: true, length: { maximum: 255 }
end
