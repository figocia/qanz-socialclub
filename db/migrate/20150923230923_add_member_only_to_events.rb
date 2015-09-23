class AddMemberOnlyToEvents < ActiveRecord::Migration
  def change
    add_column :events, :member_only, :boolean, default: false
  end
end
