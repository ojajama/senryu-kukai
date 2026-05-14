class PostRevisionsController < ApplicationController
  before_action :authenticate_user!, only: [:restore, :ai_comment]
  before_action :set_revision, only: [:show, :restore, :ai_comment]

  def index
    @post = Post.find(params[:post_id])
    @revisions = @post.post_revisions.order(created_at: :asc)
  end
  def show
  end

  def restore
    post = @revision.post

    case params[:target]
      when "before"
        post.update!(verse: @revision.before_verse)
      when "after"
        post.update!(verse: @revision.after_verse)
      else
        redirect_back fallback_location: root_path, alert: "対処できませんよぉ。"
        return
    end

    redirect_to kukai_path(post.kukai), notice: "推敲しました。"
  end

  def ai_comment
    @comment = @revision.ai_comment.presence || generate_ai_comment(@revision)
    @revision.update!(ai_comment: @comment) if @revision.ai_comment.blank? && @comment.present?

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to post_revision_path(@revision) }
    end
  rescue StandardError => e
    Rails.logger.error "AI comment failed: #{e.class}: #{e.message}"
    @comment = "AI講評を取得できませんでした。少し時間をおいてもう一度お試しください。"

    respond_to do |format|
      format.turbo_stream { render :ai_comment, status: :unprocessable_entity }
      format.html { redirect_to post_revision_path(@revision), alert: @comment }
    end
  end

  private

  def set_revision
    @revision = PostRevision.find(params[:id])
  end

  AI_COMMENT_PROMPTS = {
    "gentle" => {
      system: "あなたは川柳の優しい選者です。",
      tone:   "やさしい口調で短く、励ましを忘れずに"
    },
    "normal" => {
      system: "あなたは川柳の選者です。",
      tone:   "客観的に、簡潔に"
    },
    "strict" => {
      system: "あなたは川柳の厳格な選者です。率直に批評してください。",
      tone:   "率直に、容赦なく、改善点を具体的に"
    }
  }.freeze

  def generate_ai_comment(revision)
    raise "OPENAI_API_KEY is not set" if ENV["OPENAI_API_KEY"].blank?

    style = current_user.ai_comment_style.presence_in(AI_COMMENT_PROMPTS.keys) || "gentle"
    prompt = AI_COMMENT_PROMPTS[style]

    client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])

    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [
          { role: "system", content: prompt[:system] },
          {
            role: "user",
            content: <<~TEXT
              次の川柳の推敲差分に、短く講評してください。

              推敲前：
              #{revision.before_verse}

              推敲後：
              #{revision.after_verse}

              見るポイント：
              ・どこが良くなったか
              ・惜しいところがあれば一つだけ
              ・#{prompt[:tone]}
            TEXT
          }
        ]
      }
    )

    response.dig("choices", 0, "message", "content").to_s.strip.presence ||
      "講評を生成できませんでした。"
  end
end
