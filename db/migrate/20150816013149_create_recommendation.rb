class CreateRecommendation < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.integer :drink_id
      t.integer :subscription_id
      t.integer :show_count, :default => 0

      t.timestamps
    end
  end
end
