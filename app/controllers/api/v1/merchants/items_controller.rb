class Api::V1::Merchants::ItemsController < ApplicationController
  include MerchantParams

  def index
    render json: Merchant.find(merchant_params[:id]).items
  end

end
