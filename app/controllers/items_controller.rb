class ItemsController < ApplicationController
  after_action :generate_block, only: %i[purchase]

  def index
    @items = Item.all
  end

  def purchase
    buyer = User.find(1) # XXX: 固定
    buyer_wallet = Glueby::Wallet.load(buyer.wallet.id)
    item = Item.find(params[:id])

    amount = item.price / 100 # とりあえず 100円で １票

    vote_tokens = Glueby::Contract::Token.issue!(issuer: buyer_wallet,
                                                 token_type: Tapyrus::Color::TokenTypes::NON_REISSUABLE,
                                                 amount:)
    token_id = 'c2' + vote_tokens[0].color_id.payload.bth

    VoteToken.create!(token_id: token_id,
                      amount:,
                      user_id: buyer.id,
                      item_id: item.id)

    item.update!(display: false)

    @address = buyer_wallet.internal_wallet.receive_address
    flash[:success] = 'Success!'
    redirect_to items_path
  end

  private

  def generate_block
    Glueby::Internal::RPC.client.generatetoaddress(1, @address, ENV['AUTHORITY_KEY'])
    `rails glueby:block_syncer:start`
  end
end
