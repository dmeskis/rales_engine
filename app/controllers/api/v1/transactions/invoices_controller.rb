class Api::V1::Transactions::InvoicesController < ApplicationController
  include TransactionParams
  
  def show
    render json: Transaction.find(transaction_params[:id]).invoice
  end

end
