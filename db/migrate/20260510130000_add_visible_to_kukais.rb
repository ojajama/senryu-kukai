class AddVisibleToKukais < ActiveRecord::Migration[8.1]
  def change
    add_column :kukais, :visible, :boolean, null: false, default: true
  end
end
