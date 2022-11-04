class ItemsController < ApplicationController
  def index
    @items = Item.all
    @pickup_users = User.joins(:items).group(:id).having('COUNT(items.id) >= 1').order_voted
  end
end
