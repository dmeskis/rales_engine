class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.decimal :unit_price, precision: 8, scale: 2
      t.references :merchant

      t.timestamps
    end
  end
end
