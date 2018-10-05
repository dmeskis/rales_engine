class Api::V1::Customers::SearchController < ApplicationController
  include CustomerParams

  def show
    render json: Customer.single_finder(customer_params)
  end

  def index
    render json: Customer.find_all(customer_params)
  end

end
