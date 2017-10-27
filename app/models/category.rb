class Category < ApplicationRecord
  has_many :products

  validates :name, presence: true

  before_save{self.parent_id ||= 0}

  scope :get_sub_category, ->(id){where parent_id: id}
end
