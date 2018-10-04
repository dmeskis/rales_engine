class Api::V1::Merchants::SearchController < ApplicationController
  include MerchantParams

  def show
    render json: Merchant.single_finder(merchant_params)
  end

  def index
    render json: Merchant.find_all(merchant_params)
  end

end
