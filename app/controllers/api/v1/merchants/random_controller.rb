class Api::V1::Merchants::RandomController < ApplicationController
  include MerchantParams
  
  def show
    render json: Merchant.random_resource
  end
end
