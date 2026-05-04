class CreatePosts < ActiveRecord::Migration[8.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :kukai, null: false, foreign_key: true
      t.references :keyword, null: false, foreign_key: true
      t.string :verse

      t.timestamps
    end
  end
end
