class KukaisController < ApplicationController

  def index
    @kukais = Kukai.order(year: :desc, month: :desc)
  end

  def show
    @kukai = Kukai.find(params[:id])
    @keywords = @kukai.keywords
  end
end
