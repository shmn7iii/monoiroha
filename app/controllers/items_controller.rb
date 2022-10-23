class ItemsController < ApplicationController
  after_action :generate_block, only: %i[purchase]

  def index
    @items = Item.all
  end

  def purchase
    item = Item.find(params[:id])
    buyer = User.find(1) # XXX: 固定

    # ほんとはキーワード引数にしたい
    PurchaseItemService.call(item, buyer)

    @address = buyer.glueby_wallet.internal_wallet.receive_address
    flash[:success] = 'Success!'
    redirect_to items_path
  rescue
    flash[:danger] = 'Error!'
    redirect_to items_path
  end
end
