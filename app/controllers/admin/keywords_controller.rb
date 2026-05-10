module Admin
  class KeywordsController < BaseController
    def index
      @keywords = Keyword.order(:word)
    end

    def edit
      @keyword = Keyword.find(params[:id])
    end

    def update
      @keyword = Keyword.find(params[:id])

      if @keyword.update(keyword_params)
        redirect_to admin_keywords_path, notice: "お題を更新しました。"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def keyword_params
      params.require(:keyword).permit(:word, :reading, :pos, :category, :len)
    end
  end
end
