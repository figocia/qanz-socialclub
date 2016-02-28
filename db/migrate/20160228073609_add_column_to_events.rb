class AddColumnToEvents < ActiveRecord::Migration
  def change
    add_column :events, :is_confirmed, :boolean, default: false
  end
end
