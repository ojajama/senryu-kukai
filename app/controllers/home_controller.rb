class HomeController < ApplicationController
  def index
    @current_kukai = Kukai.order(year: :desc, month: :desc).first
  end
end
