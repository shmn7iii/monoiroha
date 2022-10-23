class VoteToken < ApplicationRecord
  belongs_to :user
  belongs_to :item

  # FIXME: 一旦こうしたが明らかにおかしい
  has_many :votes

  validates :token_id, presence: true
  validates :amount, presence: true, numericality: { only_integer: true }
end
