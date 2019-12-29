class Product < ApplicationRecord
  has_many :variants, dependent: :destroy
  validates :spu, presence: true, uniqueness: { case_sensitive: false }
end
