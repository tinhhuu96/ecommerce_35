class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :content, presence: true, length: {maximum: Settings.rating.max_length, minimum: Settings.rating.min_length}
  validates :score, presence: true

  scope :sort_by_time, ->{order(created_at: :desc)}
end
