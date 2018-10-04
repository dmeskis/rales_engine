class Api::V1::Customers::TransactionsController < ApplicationController
  include TransactionParams

  def index
    render json: Customer.find(transaction_params[:id]).transactions
  end

end
