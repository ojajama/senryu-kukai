class KukaiKeywordsController < ApplicationController
  def show
    @kukai = Kukai.find(params[:kukai_id])
    @keyword = @kukai.keywords.find(params[:id])
    @posts = @kukai.posts
                   .where(keyword: @keyword)
                   .includes(:user)
                   .order(created_at: :desc)
  end
end
