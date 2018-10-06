class Api::V1::Merchants::RevenueController < ApplicationController
  include MerchantParams

  def index
    render json: Merchant.all_total_revenue_by_date(merchant_params)
  end

  def show
    if merchant_params[:date]
      render json: Merchant.total_revenue_by_date(merchant_params)
    else
      render json: Merchant.total_revenue(merchant_params)
    end
  end

end
