class OrdersController < ApplicationController
  after_action :generate_block, only: %i[create]

  def progress
    @item_id = params[:item_id]
  end

  def create
    item = Item.find(params[:item_id])
    buyer = User.find(1) # XXX: 固定

    txid = PurchaseItemService.call(item:, buyer:)

    @address = buyer.glueby_wallet.internal_wallet.receive_address
    redirect_to orders_complete_path(item_id: item.id, txid:)
  rescue ArgumentError
    flash[:danger] = 'Error!'
    redirect_to items_path
  end

  def complete
    @item = Item.find(params[:item_id])
    @txid = params[:txid]
  end
end
