class Api::V1::Customers::FavoriteMerchantController < ApplicationController
  include CustomerParams

  def show
    render json: Customer.favorite_merchant(customer_params)
  end

end
