class UsersController < ApplicationController
  def index
    @users = User.where.not(id: 1).where.not(id: 999).order_voted
  end

  def show
    @user = User.find(params[:id])
    @voteds_hash = @user.voteds.to_h { |voted| [voted.voter.name, voted.amount] }.sort_by { |_, v| -v }.to_h
    @items = @user.items
  end
end
