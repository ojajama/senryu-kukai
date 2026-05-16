class AddKindAndVerseContextToAiGuidelines < ActiveRecord::Migration[8.1]
  def change
    add_column :ai_guidelines, :kind, :string, default: "principle", null: false
    add_column :ai_guidelines, :before_verse, :text
    add_column :ai_guidelines, :after_verse, :text
  end
end
