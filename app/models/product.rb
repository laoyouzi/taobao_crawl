class Product < ApplicationRecord
  has_many :variants
  validates :spu, presence: true, uniqueness: { case_sensitive: false }
end
