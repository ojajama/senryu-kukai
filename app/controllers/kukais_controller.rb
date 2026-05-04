class KukaisController < ApplicationController

  def index
    @kukais = Kukai.order(year: :desc, month: :desc)
  end

  def show
    @kukai = Kukai.find(params[:id])
    @keywords = @kukai.keywords
    @posts = @kukai.posts
                   .includes(:user, :keyword, :likes, comments: :user)
                   .order(created_at: :desc)
  end
end
