class ApplicationController < ActionController::Base
  private

  def generate_block
    return if @address.nil?

    Glueby::Internal::RPC.client.generatetoaddress(1, @address, ENV['AUTHORITY_KEY'])
    `rails glueby:block_syncer:start`
  end
end
