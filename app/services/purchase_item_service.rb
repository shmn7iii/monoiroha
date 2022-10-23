class PurchaseItemService < BaseService
  def initialize(item, buyer)
    @item = item
    @buyer = buyer
  end

  def call
    amount = @item.vote_amount

    vote_tokens = Glueby::Contract::Token.issue!(issuer: @buyer.glueby_wallet,
                                                 token_type: Tapyrus::Color::TokenTypes::NON_REISSUABLE,
                                                 amount:)
    token_id = 'c2' + vote_tokens[0].color_id.payload.bth

    VoteToken.create!(token_id:, amount:, user_id: @buyer.id, item_id: @item.id)
    @item.update!(display: false)
  end
end
