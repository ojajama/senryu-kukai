class AddAiCommentToPostRevisions < ActiveRecord::Migration[8.1]
  def change
    add_column :post_revisions, :ai_comment, :text
  end
end
