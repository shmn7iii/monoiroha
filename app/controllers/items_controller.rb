class ItemsController < ApplicationController
  after_action :generate_block, only: %i[purchase]

  def index
    @items = Item.all
    @pickup_users = User.order_voted
  end

  def purchase
    item = Item.find(params[:id])
    buyer = User.find(1) # XXX: 固定

    PurchaseItemService.call(item:, buyer:)

    @address = buyer.glueby_wallet.internal_wallet.receive_address
    flash[:success] = 'Success!'
    redirect_to items_path
  rescue ArgumentError
    flash[:danger] = 'Error!'
    redirect_to items_path
  end
end
