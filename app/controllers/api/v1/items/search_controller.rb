class Api::V1::Items::SearchController < ApplicationController
  include ItemParams

  def show
    render json: Item.find_by(item_params)
  end

  def index
    render json: Item.find_all(item_params)
  end

end
