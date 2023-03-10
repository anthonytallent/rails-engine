class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_many :merchants, through: :item
  has_many :discounts, through: :merchants
  
  # validates_presence_of :quantity, :unit_price, :status, :item_id, :invoice_id

  # enum status: { pending: 0, packaged: 1, shipped: 2 }
end