class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  validates_presence_of :unit_price,
                        :quantity,
                        :item_id,
                        :invoice_id

end
