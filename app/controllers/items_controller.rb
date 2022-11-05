class ItemsController < ApplicationController
  def index
    @items = Item.all
    @pickup_items = []
    User.order_voted.each do |user|
      next if user.items.on_sale.empty?
        
      @pickup_items << user.items.on_sale[0]
    end
  end
end
