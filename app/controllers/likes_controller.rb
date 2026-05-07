class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    @post = Post.find(params[:post_id])
    current_user.likes.find_or_create_by(post: @post)

    respond_to do |format|
      format.turbo_stream # create.turbo_stream.erbを呼び出す
      format.html { redirect_back fallback_location: root_path, notice: "いいねしました。" }
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post: @post)
    like&.destroy

    respond_to do |format|
      format.turbo_stream # destroy.turbo_stream.erbを呼び出す
      format.html { redirect_back fallback_location: root_path, notice: "いいねを取り消しました。" }
    end
  end
end
