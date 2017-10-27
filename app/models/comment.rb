class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :user_id, presence: true
  validates :product_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.comment.max_length, minimum: Settings.comment.min_length}

  scope :sort_by_time, ->{order(created_at: :desc)}
end
