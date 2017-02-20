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

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    before(:each) do
      @old_count = Product.count
      @product_attr = generate_product_attr
    end

    context "with all attributes present" do
      
      it "expects successful product save " do
        product = Product.new(@product_attr)
        expect(product.save).to be true
      end
    end

    context "with name attributes nil" do
      @product_attr[:name] = nil
      product = Product.new(@product_attr)

      it "expects failing product save " do
        expect(product.save).to be false
        expect(product.errors.full_messages).to include("Name can't be blank")
        expect(Product.count).to eql(@old_count)
      end
    end

    context "with category attributes nil" do
      @product_attr[:category] = nil
      product = Product.new(@product_attr)
      
      it "expects failing product save " do
        expect(product.save).to be false
        expect(product.errors.full_messages).to include("Category can't be blank")
        expect(Product.count).to eql(@old_count)
      end
    end

    context "with price attributes nil" do
      @product_attr[:price] = nil
      product = Product.new(@product_attr)
      
      it "expects failing product save " do
        expect(product.save).to be false
        expect(product.errors.full_messages).to include("Price can't be blank")
        expect(Product.count).to eql(@old_count)
      end
    end

    context "with quantity attributes nil" do
      @product_attr[:quantity] = nil
      product = Product.new(@product_attr)
      
      it "expects failing product save " do
        expect(product.save).to be false
        expect(product.errors.full_messages).to include("Quantity can't be blank")
        expect(Product.count).to eql(@old_count)
      end
    end
  end
end
