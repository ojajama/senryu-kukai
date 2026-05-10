class AddNicknameToUsers < ActiveRecord::Migration[8.1]
  def up
    add_column :users, :nickname, :string

    execute <<~SQL.squish
      UPDATE users
      SET nickname = 'user_' || id
      WHERE nickname IS NULL OR nickname = ''
    SQL

    change_column_null :users, :nickname, false
    add_index :users, "lower(nickname)", unique: true, name: "index_users_on_lower_nickname"
  end

  def down
    remove_index :users, name: "index_users_on_lower_nickname"
    remove_column :users, :nickname
  end
end
