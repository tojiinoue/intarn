class CreateLists < ActiveRecord::Migration[7.0]
  def change
    create_table :lists do |t|
      t.string :title
      t.text :body
      t.datetime :day
      t.text :result
      t.integer :point

      t.timestamps
    end
  end
end
