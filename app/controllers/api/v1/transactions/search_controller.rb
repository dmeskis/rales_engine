class Api::V1::Transactions::SearchController < ApplicationController
  include TransactionParams

  def show
    render json: Transaction.single_finder(transaction_params)
  end

  def index
    render json: Transaction.where(transaction_params)
  end

end
