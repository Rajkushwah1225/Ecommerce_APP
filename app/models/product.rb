# app/models/product.rb
class Product < ApplicationRecord
  searchkick

  def search_data
    {
      name: name,
      price: price,
      description: description
    }
  end
end
