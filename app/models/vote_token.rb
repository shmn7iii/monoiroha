class VoteToken < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_many :votes

  validates :token_id, presence: true
  validates :amount, presence: true, numericality: { only_integer: true }

  def tapyrus_token
    Glueby::Contract::Token.new(color_id: Tapyrus::Color::ColorIdentifier.parse_from_payload(token_id.htb))
  end
end
