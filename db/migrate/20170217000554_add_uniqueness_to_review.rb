class AddUniquenessToReview < ActiveRecord::Migration
  def change
    add_index :reviews, [:user_id, :product_id], unique: true
  end
end
