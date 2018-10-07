class Api::V1::Items::MostItemsController < ApplicationController
  include ItemParams

  def index
    render json: Item.most_sold_items(quantity = item_params["quantity"])
  end

end
