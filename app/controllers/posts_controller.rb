class PostsController < ApplicationController
  before_action :authenticate_user!
  def create
    @kukai = Kukai.find(params[:kukai_id])
    @post = current_user.posts.build(post_params)
    @post.kukai = @kukai

    if @post.save
      redirect_to kukai_path(@kukai), notice: "投稿しました。"
    else
      redirect_to kukai_path(@kukai), alert: "投稿できませんでした。"
    end
  end

  private

  def post_params
    params.require(:post).permit(:verse, :keyword_id)
  end
end
