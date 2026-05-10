module Admin
  class KukaisController < BaseController
    def index
      @kukais = Kukai
                  .left_joins(:keywords, :posts)
                  .select(
                    "kukais.*",
                    "COUNT(DISTINCT keywords.id) AS keywords_count",
                    "COUNT(DISTINCT posts.id) AS posts_count"
                  )
                  .group("kukais.id")
                  .order(year: :desc, month: :desc)
    end

    def new
      @kukai = Kukai.new(
        year: Date.current.year,
        month: Date.current.month,
        title: "#{Date.current.year}年#{Date.current.month}月句会"
      )
      @keyword_count = 5
    end

    def create
      @kukai = Kukai.new(kukai_params)
      @keyword_count = params[:keyword_count].presence || 5

      if @kukai.save
        @kukai.assign_random_keywords!(@keyword_count)
        redirect_to admin_kukais_path, notice: "句会を作成しました。"
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def kukai_params
      params.require(:kukai).permit(:title, :year, :month)
    end
  end
end
