class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_own_post, only: [:edit, :update, :destroy]
  before_action :set_keywords, only: [:edit, :update]
  def create
    @kukai = Kukai.find(params[:kukai_id])
    @keywords = @kukai.keywords

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
      respond_to do |format|
        format.turbo_stream { render :edit, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
        format.turbo_stream
        format.html { redirect_to kukai_path(@post.kukai), notice: "投稿を削除しました。" }
     end

  end

  private

  def set_own_post
    @post = current_user.posts.find(params[:id])
  end

  def set_keywords
    @keywords = @post.kukai.keywords
  end

  def post_params
    params.require(:post).permit(:verse, :keyword_id)
  end
end
