class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_own_post, only: [:edit, :update, :destroy]
  def create
    @kukai = Kukai.find(params[:kukai_id])
    @post = current_user.posts.build(post_params)
    @post.kukai = @kukai

    if @post.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to kukai_path(@kukai), notice: "投稿しました。" }
      end
      
    else
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to kukai_path(@kukai), alert: "投稿できませんでした。" }
      end
    end
  end

  def edit
  end

  def update
    old_verse = @post.verse

    if @post.update(post_params)
      if old_verse != @post.verse
        @post.post_revisions.create!(
          before_verse: old_verse,
          after_verse: @post.verse
        )
      end

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to kukai_path(@post.kukai), notice: "投稿を更新しました。" }
      end

    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    kukai = @post.kukai
    @post.destroy

    respond_to do |format|
        format.turbo_stream
        format.html { redirect_to kukai_path(kukai), notice: "投稿を削除しました。" }
     end

  end

  private

  def set_own_post
    @post = current_user.posts.find_by(id: params[:id])
  end

  def post_params
    params.require(:post).permit(:verse, :keyword_id)
  end
end
