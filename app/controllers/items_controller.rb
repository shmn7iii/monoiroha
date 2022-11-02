class ItemsController < ApplicationController
  def index
    @items = Item.all
    @pickup_users = User.order_voted
  end
end
