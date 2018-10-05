class Api::V1::Customers::SearchController < ApplicationController
  include CustomerParams

  def show
    render json: Customer.single_finder(customer_params)
  end

  def index
    render json: Customer.multi_finder(customer_params)
  end

end
