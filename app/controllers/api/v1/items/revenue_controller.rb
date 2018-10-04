class Api::V1::Items::RevenueController < ApplicationController
  include ItemParams
  
  def index
    render json: Item.top_revenue_items(item_params)
  end

end
