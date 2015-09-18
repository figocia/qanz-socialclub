class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, :address, :description
      t.boolean :member_only, default: false
      t.datetime :time
      t.timestamps
    end
  end
end
