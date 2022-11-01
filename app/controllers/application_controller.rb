class ApplicationController < ActionController::Base
  helper_method :user_name
  private

  def generate_block
    return if @address.nil?

    Glueby::Internal::RPC.client.generatetoaddress(1, @address, ENV['AUTHORITY_KEY'])
    `rails glueby:block_syncer:start`
  end

  def user_name
    name = User.find(1).name
    return name
  end
end
