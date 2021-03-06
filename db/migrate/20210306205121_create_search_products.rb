class CreateSearchProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :search_products do |t|
      t.string :product
      t.string :sort
      t.integer :quantity

      t.timestamps
    end
  end
end
