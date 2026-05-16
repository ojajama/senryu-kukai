module Admin
  class PostRevisionsController < BaseController
    def save_as_example
      revision = PostRevision.find(params[:id])

      unless revision.ai_comment.present?
        redirect_back fallback_location: post_revision_path(revision), alert: "AI選評がまだありません。"
        return
      end

      guideline = AiGuideline.create!(
        kind: :example,
        before_verse: revision.before_verse,
        after_verse: revision.after_verse,
        body: revision.ai_comment,
        active: true
      )

      redirect_back fallback_location: post_revision_path(revision), notice: "良い例として保存しました。"
    end
  end
end
