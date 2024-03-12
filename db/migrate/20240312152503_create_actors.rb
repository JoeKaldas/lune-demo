class CreateActors < ActiveRecord::Migration[7.1]
  def change
    create_table :actors do |t|
      t.citext :name, null: false
      t.timestamps
    end
  end
end
