class AddEmailAndInitialPasswordToInvitations < ActiveRecord::Migration[8.1]
  def change
    add_column :invitations, :email, :string
    add_column :invitations, :initial_password, :string
  end
end
