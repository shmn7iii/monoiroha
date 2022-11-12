class ResetController < ApplicationController
  before_action :basic_auth, only: %i[index create]

  def index; end

  def create
    `DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bin/rails db:drop`
    `bin/rails db:create`
    `bin/rails db:migrate`
    `bin/rails ridgepole:apply`
    `bin/rails db:seed`
    `bin/rails restart`

    flash[:success] = 'サーバーの再起動中です。しばらくしてからページをリロードしてください。'
    redirect_to root_path
  end
end
