class CreateDrinks < ActiveRecord::Migration
  def change
    create_table :drinks do |t|
      t.string :img_url
      t.string :name
      t.integer :site_id

      t.timestamps
    end
  end
end
