class TransactionsController < ApplicationController
  def show
    id = params[:id]

    @transaction = SearchTransactionService.call(user: User.find(1), id:) # XXX: 固定
    @transaction_json = JSON.pretty_generate(@transaction.to_h)
  rescue ArgumentError, Tapyrus::RPC::Error
    flash[:danger] = 'No transactions found :('
    safe_redirect_to root_path
  end
end
