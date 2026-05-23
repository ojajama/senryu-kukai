class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_post, only: [:show]
  before_action :set_own_post, only: [:edit, :update, :destroy]
  before_action :set_keywords, only: [:edit, :update]

  def show
  end

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
      @post_error_message = post_error_message(@post)

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to kukai_path(@kukai), alert: @post_error_message }
      end
    end
  end

  def edit
    if @post.verse_upper.blank? && @post.verse_middle.blank? && @post.verse_lower.blank? && @post.verse.present?
      parts = @post.verse.split(/[　 ]/, 3)
      @post.verse_upper  = parts[0]
      @post.verse_middle = parts[1]
      @post.verse_lower  = parts[2]
    end
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
        format.html { redirect_to post_path(@post), notice: "投稿を更新しました。" }
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

  def set_post
    @post = Post.find(params[:id])
  end

  def set_own_post
    @post = current_user.posts.find(params[:id])
  end

  def set_keywords
    @keywords = @post.kukai.keywords
  end

  def post_params
    params.require(:post).permit(:verse, :verse_upper, :verse_middle, :verse_lower, :keyword_id)
  end

  def post_error_message(post)
    return "お題を選んでください。" if post.errors[:keyword].any?
    return "川柳を入力してください。" if post.errors[:verse].any?

    "投稿できませんでした。"
  end
end
