class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items, dependent: :delete_all
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  
  # validates_presence_of :status, :customer_id

  # enum status: { 'in progress' => 0, completed: 1, cancelled: 2 }

  def self.delete_invoices(invoices, item)
    invoices.each do |invoice|
      if invoice.only_item_on_invoice?(item)
        invoice.destroy
      end
    end
  end

  def only_item_on_invoice?(item)
    items.count == 1 && items.first.id == item.id
  end
end