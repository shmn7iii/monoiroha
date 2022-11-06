class OrdersController < ApplicationController
  before_action :set_item
  after_action :generate_block, only: %i[create]

  def progress; end

  def create
    buyer = User.find(1) # XXX: 固定

    PurchaseItemService.call(item: @item, buyer:)

    @address = buyer.glueby_wallet.internal_wallet.receive_address

    # 本番環境用リダイレクト
    if Rails.env.production?
      redirect_to "https://monoiroha.shmn7iii.net/orders/complete?item_id=#{@item.id}", allow_other_host: true
    else
      redirect_to orders_complete_path(item_id: @item.id)
    end
  rescue StandardError
    flash[:danger] = 'Error!'
    if Rails.env.production?
      redirect_to 'https://monoiroha.shmn7iii.net/items', allow_other_host: true
    else
      redirect_to items_path
    end
  end

  def complete
    @txid = @item.txid
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end
end
