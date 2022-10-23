class Item < ApplicationRecord
  belongs_to :user
  has_one :vote_token

  validates :title, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 255 }
  validates :price, presence: true, numericality: { greater_than: 0, only_integer: true }

  def vote_amount
    # とりあえず 100円で １票
    price / 100
  end
end
