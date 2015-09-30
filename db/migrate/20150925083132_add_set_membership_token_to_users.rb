class AddSetMembershipTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :membership_token, :string
  end
end
