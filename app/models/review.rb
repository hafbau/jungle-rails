class Review < ActiveRecord::Base

  belongs_to :product

  validates :user_id, presence: true
  validates :product_id, presence: true
  validates :descriptions, presence: true
  validates :rating, presence: true

end
