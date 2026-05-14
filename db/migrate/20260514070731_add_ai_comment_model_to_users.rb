class AddAiCommentModelToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :ai_comment_model, :string, default: "openai", null: false
  end
end
