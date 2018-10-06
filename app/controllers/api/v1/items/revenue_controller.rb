class Api::V1::Items::RevenueController < ApplicationController
  include ItemParams

  def index
    render json: Item.top_revenue_items(quantity = item_params["quantity"].to_i)
  end

end
