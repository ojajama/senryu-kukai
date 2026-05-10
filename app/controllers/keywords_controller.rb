class KeywordsController < ApplicationController
  def index
    @keywords = Keyword
                  .includes(:kukais)
                  .left_joins(:posts)
                  .select("keywords.*, COUNT(posts.id) AS posts_count")
                  .group("keywords.id")
                  .order(:word)
  end
end
