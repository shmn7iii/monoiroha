class UsersController < ApplicationController
  def index
    @users = User.where.not(id: 1)
  end
end