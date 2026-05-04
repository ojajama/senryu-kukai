class CreateKukais < ActiveRecord::Migration[8.1]
  def change
    create_table :kukais do |t|
      t.integer :year
      t.integer :month
      t.string :title

      t.timestamps
    end
  end
end
