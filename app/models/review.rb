class Review < ActiveRecord::Base

  belongs_to :product

  validates :user_id, presence: true, uniqueness: { scope: product_id }
  validates :product_id, presence: true
  validates :description, presence: true
  validates :rating, presence: true,
            numericality: true,
            inclusion: { in: 1..5 }

end
