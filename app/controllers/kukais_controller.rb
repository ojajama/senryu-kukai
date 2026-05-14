class KukaisController < ApplicationController

  def index
    @kukais = Kukai.visible.order(year: :desc, month: :desc)
  end

  def show
    @kukai = Kukai.find(params[:id])
    @keywords = @kukai.keywords
    @posts = @kukai.posts
                   .includes(:user, :keyword, :likes, comments: :user)
                   .order(created_at: :desc)
  end

  def ranking
    @kukai = Kukai.find(params[:id])
    @ranked_posts = @kukai.posts
                          .left_joins(:likes)
                          .group(:id)
                          .order("COUNT(likes.id) DESC, posts.created_at ASC")
                          .includes(:user, :keyword)
                          .select("posts.*, COUNT(likes.id) AS likes_count")
  end

end
