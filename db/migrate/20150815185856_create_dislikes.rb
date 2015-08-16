class CreateDislikes < ActiveRecord::Migration
  def change
    create_table :dislikes do |t|
      t.integer :drink_id
      t.integer :subscription_id

      t.timestamps
    end
  end
end
