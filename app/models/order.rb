class Order < ActiveRecord::Base

  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  before_create :check_n_update_quantities

  private

  def check_n_update_quantities
    self.line_items.each do |item|
      curr_quantity = item.product.quantity - item.quantity
      if curr_quantity < 0
        errors[:base] << "Sorry, there are only #{item.product.quantity}#{item.product.name} in stock."
        false
      else
        item.product.update(quantity: curr_quantity)
      end
    end
  end
end
