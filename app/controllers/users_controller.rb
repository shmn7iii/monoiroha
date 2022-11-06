class UsersController < ApplicationController
  def index
    @users = User.where.not(id: 1).where.not(id: 999)
  end
end