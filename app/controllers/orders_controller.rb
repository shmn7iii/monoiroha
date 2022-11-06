class OrdersController < ApplicationController
  after_action :generate_block, only: %i[create]

  def progress
    @item_id = params[:item_id]
  end

  def create
    item = Item.find(params[:item_id])
    buyer = User.find(1) # XXX: 固定

    item = PurchaseItemService.call(item:, buyer:)

    @address = buyer.glueby_wallet.internal_wallet.receive_address

    # 本番環境用リダイレクト
    if Rails.env.production?
      redirect_to "https://monoiroha.shmn7iii.net/orders/complete?item_id=#{item.id}", allow_other_host: true
    else
      redirect_to orders_complete_path(item_id: item.id)
    end
  rescue ArgumentError
    flash[:danger] = 'Error!'
    redirect_to items_path
  end

  def complete
    @item = Item.find(params[:item_id])
    @txid = @item.txid
  end
end
