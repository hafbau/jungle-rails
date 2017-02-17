class Review < ActiveRecord::Base

  belongs_to :product
  belongs_to :user

  validates :user_id, presence: { message: "must login to review this product" }
  validates :user_id, uniqueness: { scope: :product_id, message: "has already rated this" }
  validates :product_id, presence: true
  validates :description, presence: true
  validates :rating, presence: true,
            numericality: true,
            inclusion: { in: 1..5 }

end
