class Api::V1::Merchants::MostRevenueController < ApplicationController
  include MerchantParams

  def index
    render json: Merchant.most_revenue(quantity = merchant_params["quantity"].to_i)
  end
end
