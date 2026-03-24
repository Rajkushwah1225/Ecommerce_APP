# app/models/product.rb
class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }

  searchkick

  def search_data
    {
      name: name,
      price: price,
      description: description
    }
  end
end
