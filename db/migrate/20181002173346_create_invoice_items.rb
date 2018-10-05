class CreateInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    create_table :invoice_items do |t|
      t.references :item, foreign_key: true
      t.references :invoice, foreign_key: true
      t.bigint :quantity, precision: 8, scale: 2
      t.decimal :unit_price

      t.timestamps
    end
  end
end
