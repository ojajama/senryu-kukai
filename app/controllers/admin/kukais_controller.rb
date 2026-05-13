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

    def edit
      @kukai = Kukai.includes(:keywords).find(params[:id])
      set_keyword_candidates
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

    def update
      @kukai = Kukai.find(params[:id])

      if @kukai.update(kukai_params)
        redirect_to admin_kukais_path, notice: "句会を更新しました。"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def add_random_keyword
      kukai = Kukai.find(params[:id])
      before_count = kukai.keywords.count
      kukai.assign_one_random_keyword!

      if kukai.keywords.count > before_count
        redirect_to edit_admin_kukai_path(kukai), notice: "お題を追加しました。"
      else
        redirect_to edit_admin_kukai_path(kukai), alert: "追加できるお題がありません。"
      end
    end

    def add_keyword
      kukai = Kukai.find(params[:id])
      keyword = Keyword.find(params[:keyword_id])
      kukai.kukai_keywords.find_or_create_by!(keyword: keyword)

      redirect_to edit_admin_kukai_path(kukai), notice: "お題を追加しました。"
    end

    def remove_keyword
      kukai = Kukai.find(params[:id])
      kukai.kukai_keywords.find_by!(keyword_id: params[:keyword_id]).destroy

      redirect_to edit_admin_kukai_path(kukai), notice: "お題を外しました。"
    end

    private

    def kukai_params
      params.require(:kukai).permit(:title, :year, :month, :visible)
    end

    def set_keyword_candidates
      @keyword_query = params[:keyword_q].to_s.strip
      @keyword_candidates = Keyword.where.not(id: @kukai.keyword_ids).order(:word).limit(20)

      return if @keyword_query.blank?

      like_query = "%#{ActiveRecord::Base.sanitize_sql_like(@keyword_query)}%"
      @keyword_candidates = @keyword_candidates.where(
        "word ILIKE :query OR reading ILIKE :query OR category ILIKE :query",
        query: like_query
      )
    end
  end
end
