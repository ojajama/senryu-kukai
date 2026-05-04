class KukaisController < ApplicationController
  def show
    @kukai = Kukai.find(params[:id])
  end
end
