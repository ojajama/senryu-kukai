module Admin
  class AiGuidelinesController < BaseController
    before_action :set_guideline, only: [:edit, :update, :destroy]

    def index
      @guidelines = AiGuideline.order(created_at: :asc)
    end

    def new
      @guideline = AiGuideline.new
    end

    def create
      @guideline = AiGuideline.new(guideline_params)
      if @guideline.save
        redirect_to admin_ai_guidelines_path, notice: "指針を追加しました。"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @guideline.update(guideline_params)
        redirect_to admin_ai_guidelines_path, notice: "指針を更新しました。"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @guideline.destroy
      redirect_to admin_ai_guidelines_path, notice: "指針を削除しました。"
    end

    private

    def set_guideline
      @guideline = AiGuideline.find(params[:id])
    end

    def guideline_params
      params.require(:ai_guideline).permit(:body, :active)
    end
  end
end
