class ChangeAiCommentStyleDefaultOnUsers < ActiveRecord::Migration[8.1]
  def change
    change_column_default :users, :ai_comment_style, from: nil, to: "normal"
    change_column_null :users, :ai_comment_style, false, "normal"
  end
end
