class OrderDetail < ApplicationRecord
  belongs_to :product
  belongs_to :order

  before_save :finalize

  validates :quantity, presence: true, numericality: {only_integer: true, greater_than: 0}

  def unit_price
    if persisted?
      self[:current_price]
    else
      product.price
    end
  end

  def total_price
    unit_price.to_i * quantity.to_i
  end

  private

  def finalize
    self[:current_price] = unit_price
    self[:total_price] = quantity * self[:current_price]
  end
end
