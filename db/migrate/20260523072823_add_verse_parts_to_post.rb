class AddVersePartsToPost < ActiveRecord::Migration[8.1]
  def change
    add_column :posts, :verse_upper, :string
    add_column :posts, :verse_middle, :string
    add_column :posts, :verse_lower, :string
  end
end
