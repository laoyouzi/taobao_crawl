class Variant < ApplicationRecord
  belongs_to :product
  validates :sku, presence: true, uniqueness: { case_sensitive: false }
  enum status: { pending: 0, processed: 1 }

  scope :unstock, -> { where(quantity: 0) }
  scope :instock, -> { where('quantity > 0')}

  scope :instock_with_pending, -> {
    where('quantity > 0 and status = 0')
  }
  scope :unstock_with_pending, -> {
    where(quantity: 0, status: 0)
  }
end
