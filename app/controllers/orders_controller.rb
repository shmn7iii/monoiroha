class OrdersController < ApplicationController
  before_action :set_item
  after_action :generate_block, only: %i[create]

  def progress; end

  def create
    buyer = User.find(1) # XXX: 固定

    PurchaseItemService.call(item: @item, buyer:)

    @address = buyer.glueby_wallet.internal_wallet.receive_address

    redirect_to orders_complete_path(item_id: @item.id)
  rescue StandardError
    flash[:danger] = 'Error!'
    redirect_to items_path
  end

  def complete
    @txid = @item.txid
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end
end
