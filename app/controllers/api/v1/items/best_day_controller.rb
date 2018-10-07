class Api::V1::Items::BestDayController < ApplicationController
  include ItemParams

  def show
    render json: Item.best_day(item_params)
  end

end
