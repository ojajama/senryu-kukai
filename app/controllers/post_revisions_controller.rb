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

    redirect_to kukai_path(post.kukai), notice: "推敲しました。"
  end

  def ai_comment
    @revision = PostRevision.find(params[:id])

    client = OpenAI::Client.new(
      access_token: ENV["OPENAI_API_KEY"]
    )

    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [
          {
            role: "system",
            content: "あなたは川柳の優しい選者です。"
          },
          {
            role: "user",
            content: <<~TEXT
              次の川柳の推敲差分に、短く講評してください。

              推敲前：
              #{@revision.before_verse}

              推敲後：
              #{@revision.after_verse}

              見るポイント：
              ・どこが良くなったか
              ・惜しいところがあれば一つだけ
              ・やさしい口調で短く
            TEXT
          }
        ]
      }
    )

    Rails.logger.info "OPENAI RESPONSE: #{response.inspect}"

    @comment = response.dig("choices", 0, "message", "content")

    Rails.logger.info "AI comment: #{@comment.inspect}"

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to post_revision_path(@revision) }
    end
  end
end
