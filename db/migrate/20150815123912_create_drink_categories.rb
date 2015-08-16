class CreateDrinkCategories < ActiveRecord::Migration
  def change
    create_table :drink_categories do |t|
      t.integer :drink_id
      t.integer :category_id

      t.timestamps
    end
  end
end
