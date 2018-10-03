class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    merchant = Merchant.find(params[:id])
    render json: Merchant.total_revenue(merchant.id)
  end

end
