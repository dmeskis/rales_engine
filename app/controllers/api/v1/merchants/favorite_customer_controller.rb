class Api::V1::Merchants::FavoriteCustomerController < ApplicationController
  include MerchantParams

  def show
    render json: Merchant.favorite_customer(merchant_params)
  end

end
