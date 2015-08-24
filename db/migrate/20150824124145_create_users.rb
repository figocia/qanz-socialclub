class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, :email
      t.boolean :is_member, default: false
      t.timestamps
    end
  end
end
