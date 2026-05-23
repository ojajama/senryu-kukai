require "csv"

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

    def import
      file = params[:file]
      unless file
        redirect_to admin_keywords_path, alert: "CSVファイルを選択してください。"
        return
      end

      added = 0
      skipped = 0
      errors = []

      content = file.read.force_encoding("UTF-8")
      content.sub!("\xEF\xBB\xBF", "")

      CSV.parse(content, headers: true) do |row|
        word = row["word"]&.strip.presence
        unless word
          skipped += 1
          next
        end

        keyword = Keyword.find_or_initialize_by(word: word)
        if keyword.new_record?
          keyword.assign_attributes(
            reading:  row["reading"]&.strip,
            pos:      row["pos"]&.strip,
            sub_pos:  row["sub_pos"]&.strip,
            category: row["category"]&.strip,
            sub_cate: row["sub_cate"]&.strip,
            len:      row["len"]&.strip&.presence&.to_i
          )
          if keyword.save
            added += 1
          else
            errors << "「#{word}」: #{keyword.errors.full_messages.join(', ')}"
          end
        else
          skipped += 1
        end
      end

      msg = "#{added}件追加、#{skipped}件スキップ"
      msg += "（エラー #{errors.size}件）" if errors.any?
      redirect_to admin_keywords_path, notice: msg
    end

    private

    def keyword_params
      params.require(:keyword).permit(:word, :reading, :pos, :sub_pos, :category, :sub_cate, :len)
    end
  end
end
