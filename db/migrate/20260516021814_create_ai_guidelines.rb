class CreateAiGuidelines < ActiveRecord::Migration[8.1]
  def change
    create_table :ai_guidelines do |t|
      t.text :body
      t.boolean :active, default: true, null: false

      t.timestamps
    end
  end
end
