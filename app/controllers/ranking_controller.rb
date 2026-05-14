class RankingController < ApplicationController
  def show
    @year = params[:year]&.to_i || Date.today.year
    @available_years = Kukai.distinct.order(year: :desc).pluck(:year)

    @ranked_posts = Post.joins(:kukai)
                        .where(kukais: { year: @year })
                        .left_joins(:likes)
                        .group("posts.id")
                        .order("COUNT(likes.id) DESC, posts.created_at ASC")
                        .includes(:user, :keyword, :kukai)
                        .select("posts.*, COUNT(likes.id) AS likes_count")
  end
end
