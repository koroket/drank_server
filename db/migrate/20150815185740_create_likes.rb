class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :drink_id
      t.integer :subscription_id

      t.timestamps
    end
  end
end
