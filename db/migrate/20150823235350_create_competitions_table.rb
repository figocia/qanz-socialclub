class CreateCompetitionsTable < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :name
      t.boolean :is_finished, default: false
      t.timestamps
    end
  end
end
