class CreateKukaiKeywords < ActiveRecord::Migration[8.1]
  def change
    create_table :kukai_keywords do |t|
      t.references :kukai, null: false, foreign_key: true
      t.references :keyword, null: false, foreign_key: true

      t.timestamps
    end
  end
end
