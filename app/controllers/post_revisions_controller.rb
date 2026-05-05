class PostRevisionsController < ApplicationController

  def index
    @post = Post.find(params[:post_id])
    @revisions = @post.post_revisions.order(created_at: :asc)
  end
  def show
    @revision = PostRevision.find(params[:id])
  end

  def restore
    revision = PostRevision.find(params[:id])
    post = revision.post

    case params[:target]
      when "before"
        post.update!(verse: revision.before_verse)
      when "after"
        post.update!(verse: revision.after_verse)
      else
        redirect_to fallback_location: root_path, alert: "対処できませんよぉ。"
        return
    end

    redirect_to kukai_path(post.kukai), notice: "版を変更しました。"
  end

  def ai_comment
    revision = PostRevision.find(params[:id])

    revision.update!(
      ai_comment: "テストコメント"
    )

    redirect_to post_revision_path(revision)
  end
end
