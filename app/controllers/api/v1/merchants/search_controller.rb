class Api::V1::Merchants::SearchController < ApplicationController
  include MerchantParams

  def show
    render json: Merchant.find_by(merchant_params)
  end

  def index
    render json: Merchant.find_all(merchant_params)
  end

end
