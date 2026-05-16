class KukaisController < ApplicationController

  def index
    @kukais = Kukai.visible.order(year: :desc, month: :desc)
  end

  def show
    @kukai = Kukai.find(params[:id])
    @keywords = @kukai.keywords
    @posts = @kukai.posts
                   .includes(:user, :keyword, :likes, :selections, :post_revisions, comments: :user)
                   .order(created_at: :desc)
    if user_signed_in?
      @my_selections = current_user.selections.where(kukai: @kukai).index_by(&:post_id)
      @my_selection_count = @my_selections.size
    end
  end

  def ranking
    @kukai = Kukai.find(params[:id])
    @ranked_posts = @kukai.posts
                          .left_joins(:likes)
                          .group(:id)
                          .order("COUNT(likes.id) DESC, posts.created_at ASC")
                          .preload(:user, :keyword)
                          .select("posts.*, COUNT(likes.id) AS likes_count")
  end

end
