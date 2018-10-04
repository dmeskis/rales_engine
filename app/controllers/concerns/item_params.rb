module ItemParams
  private

  def item_params
    params.permit(:quantity)
  end
end
