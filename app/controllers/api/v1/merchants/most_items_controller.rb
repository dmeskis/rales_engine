class Api::V1::Merchants::MostItemsController < ApplicationController
  include MerchantParams

  def index
    render json: Merchant.most_items(quantity = merchant_params["quantity"].to_i)
  end
end
