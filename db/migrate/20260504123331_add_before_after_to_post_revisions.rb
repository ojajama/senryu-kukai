class AddBeforeAfterToPostRevisions < ActiveRecord::Migration[8.1]
  def change
    add_column :post_revisions, :before_verse, :text
    add_column :post_revisions, :after_verse, :text
  end
end
