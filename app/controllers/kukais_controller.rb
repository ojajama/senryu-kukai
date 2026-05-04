class KukaisController < ApplicationController
  def show
    @kukai = Kukai.find(params[:id])
    @keywords = @kukai.keywords
  end
end
