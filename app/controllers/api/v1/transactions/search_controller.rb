class Api::V1::Transactions::SearchController < ApplicationController
  include TransactionParams

  def show
    render json: Transaction.find_by(transaction_params)
  end

  def index
    render json: Transaction.find_all(transaction_params)
  end

end
