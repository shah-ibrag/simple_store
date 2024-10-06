# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'csv'


# Read data from CSV file
csv_file = Rails.root.join('db/products.csv')
csv_data = File.read(csv_file)

products = CSV.parse(csv_data, headers: true)

# If CSV was created by Excel in Windows you may also need to set an encoding type:
# products = CSV.parse(csv_data, headers: true, encoding: 'iso-8859-1')

products.each do |product|
  category_name = product['category']
  category = Category.find_or_create_by(name: category_name)

  
  title = product['name']
  description = product['description']
  price = product['price']
  stock_quantity = product['stock quantity']

  if title.present? && stock_quantity.present?
    new_product = Product.new(
      title: title,
      description: description,
      price: price,
      stock_quantity: stock_quantity,
      category_id: category.id
    )
end