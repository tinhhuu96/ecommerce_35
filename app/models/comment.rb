class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :user_id, presence: true
  validates :product_id, presence: true

  scope :sort_by_time, ->{order(created_at: :desc)}
end
