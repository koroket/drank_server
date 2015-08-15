class CreateDrinkIngredients < ActiveRecord::Migration
  def change
    create_table :drink_ingredients do |t|
      t.string :amount
      t.integer :drink_id
      t.integer :ingredient_id

      t.timestamps
    end
  end
end
