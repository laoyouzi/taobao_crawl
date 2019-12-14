class Variant < ApplicationRecord
  belongs_to :product
  validates :sku, presence: true, uniqueness: { case_sensitive: false }

  scope :unstock, -> { where(quantity: 0) }
  scope :instock, -> { where('quantity > 0')}
end
