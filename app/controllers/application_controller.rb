class ApplicationController < ActionController::Base
  helper_method :user_name

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |user, pass|
      user == ENV['BASIC_AUTH_USER'] && pass == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  def generate_block
    return if @address.nil?

    Glueby::Internal::RPC.client.generatetoaddress(1, @address, ENV['AUTHORITY_KEY'])
    `rails glueby:block_syncer:start`
  end

  # 本番環境対応リダイレクト
  def safe_redirect_to(path)
    if Rails.env.production?
      redirect_to "https://monoiroha.shmn7iii.net#{path}", allow_other_host: true
    else
      redirect_to path
    end
  end

  def user_name
    User.find(1).name
  end
end
