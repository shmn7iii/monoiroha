class PurchaseItemService < BaseService
  def initialize(item:, buyer:)
    @item = item
    @buyer = buyer

    super()
  end

  def call
    raise ArgumentError if @item.nil? || @buyer.nil? || @item.purchased_at.present?

    amount = @item.vote_amount
    vote_tokens = Glueby::Contract::Token.issue!(issuer: @buyer.glueby_wallet,
                                                 token_type: Tapyrus::Color::TokenTypes::NON_REISSUABLE,
                                                 amount:)
    token_id = 'c2' + vote_tokens[0].color_id.payload.bth

    VoteToken.create!(token_id:, amount:, user_id: @buyer.id, item_id: @item.id)
    @item.update!(purchased_at: Time.current)
    @item.update!(txid: vote_tokens[1][0].txid)

    @item
  end
end
