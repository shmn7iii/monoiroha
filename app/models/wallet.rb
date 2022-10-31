class Wallet < ApplicationRecord
  has_one :user
  has_many :items, through: :user
end
