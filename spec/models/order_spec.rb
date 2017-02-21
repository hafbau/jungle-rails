require 'rails_helper'

def generate_product_attr
  category = Category.new(name: Faker::Name.name)
  product_attr = {
    name: Faker::Name.name,
    price: 1 + (rand(10) * 100),
    quantity: 1 + (rand(10) * 10),
    category: category
  }
end

def create_order(products)
  order = Order.new({
    email: Faker::Internet.free_email,
    total_cents: 100 + (rand(10) * 100),
    stripe_charge_id: 1 + (rand(10) * 10), # returned by stripe
  })
  products.each do |product, details|
    quantity = 2
    order.line_items.new(
      product: product,
      quantity: quantity,
      item_price: product.price,
      total_price: product.price * quantity
    )
  end
  order
end

RSpec.describe Order, type: :model do
  describe 'After creation' do
    before :each do
      # Setup at least two products with different quantities, names, etc
      @product1 = Product.create!(generate_product_attr)
      @product2 = Product.create!(generate_product_attr)
      # Setup at least one product that will NOT be in the order
      @product3 = Product.create!(generate_product_attr)
      @old_prod1_quantity = @product1.quantity
      @old_prod2_quantity = @product2.quantity
      @old_prod3_quantity = @product3.quantity
    end

    it 'deducts quantity from products based on their line item quantities' do
      # TODO: Implement based on hints below
      # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)
      @order = create_order([@product1, @product2])
      # 2. build line items on @order
      # ...
      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      # 5. use RSpec expect syntax to assert their new quantity values
      expect(@old_prod1_quantity - @product1.quantity).to eql(2)
      expect(@old_prod2_quantity - @product2.quantity).to eql(2)
    end

    
    it 'does not deduct quantity from products that are not in the order' do
      # TODO: Implement based on hints in previous test
      # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)
      @order = create_order([@product1, @product2])
      # 2. build line items on @order
      # ...
      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      # 4. reload products to have their updated quantities
      @product3.reload
      expect(@old_prod3_quantity - @product3.quantity).to eql(0)
    end
  end
end