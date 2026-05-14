class AddAiCommentStyleToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :ai_comment_style, :string, default: "gentle", null: false
  end
end
