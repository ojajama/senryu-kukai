class HomeController < ApplicationController
  def index
    @current_kukai = Kukai.visible.find_by(
      year: Date.current.year,
      month: Date.current.month
    )
  end
end
