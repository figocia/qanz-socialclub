class AddPriceToEvents < ActiveRecord::Migration
  def change
    add_column :events, :non_member_fee, :decimal, precision: 5, scale: 2
  end
end
