class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details, dependent: :destroy

  before_create :set_order_status
  before_save :update_subtotal

  enum status: {in_progress: 1, placed: 2, shipped: 3, cancelled: 4}

  scope :sort_by_created, ->{order created_at: :DESC}

  def subtotal
    order_details.collect{|oi| oi.valid? ? (oi.quantity.to_i * oi.current_price.to_i) : 0}.sum
  end

  def add_product product_params
    current_item = order_details.find_by product_id: product_params[:product_id]
    if current_item
      current_item.quantity += product_params[:quantity].to_i
      current_item.save
    else
      new_item = order_details.new(product_id: product_params[:product_id],
        quantity: product_params[:quantity])
    end
  end

  private

  def set_order_status
    self.status = "in_progress"
  end

  def update_subtotal
    self[:subtotal] = subtotal
  end
end
