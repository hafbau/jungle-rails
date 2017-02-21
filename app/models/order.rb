class Order < ActiveRecord::Base

  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  after_create :update_quantities

  private

  def update_quantities
    self.line_items.each do |item|
      curr_quantity = item.product.quantity - item.quantity
      item.product.update(quantity: curr_quantity)
    end
  end
end
