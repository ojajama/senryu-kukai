class AddMetadataToKeywords < ActiveRecord::Migration[8.1]
  def up
    add_column :keywords, :reading, :string
    add_column :keywords, :pos, :string
    add_column :keywords, :category, :string
    add_column :keywords, :len, :integer

    execute <<~SQL.squish
      UPDATE keywords
      SET category = ''
      WHERE category IS NULL
    SQL

    change_column_null :keywords, :word, false
    add_index :keywords, :word, unique: true
    add_index :keywords, :reading
    add_index :keywords, :pos
    add_index :keywords, :category
    add_index :keywords, :len
  end

  def down
    remove_index :keywords, :len
    remove_index :keywords, :category
    remove_index :keywords, :pos
    remove_index :keywords, :reading
    remove_index :keywords, :word

    change_column_null :keywords, :word, true

    remove_column :keywords, :len
    remove_column :keywords, :category
    remove_column :keywords, :pos
    remove_column :keywords, :reading
  end
end
