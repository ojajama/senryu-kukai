class AddSubPosAndSubCateToKeywords < ActiveRecord::Migration[8.1]
  def change
    add_column :keywords, :sub_pos, :string
    add_column :keywords, :sub_cate, :string
  end
end
