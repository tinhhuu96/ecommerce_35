class Product < ApplicationRecord
  belongs_to :category
  has_one :parameter, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :comments, dependent: :destroy

  mount_uploader :picture, PictureUploader

  validates :name, presence: true, length: {maximum: Settings.product.name.maximum_length}
  validates :price, presence: true
  validates :quantity, presence: true,
    numericality: {only_integer: true, greater_than_or_equal_to: Settings.product.than}

  default_scope{where(active: true)}
  scope :sort_by_name, ->{order :name}
  scope :search_by_name, ->(content){where(" name like ?", "%#{content}%")}
  scope :search_by_price, ->(prices){where(price: prices) if prices.present?}
  scope :search_by_cate, ->(category_id){where category_id: category_id}
  scope :hot_trend, ->{joins(:order_details)
    .where("order_details.created_at >= DATE_FORMAT( CURRENT_DATE - INTERVAL 1 MONTH, '%Y/%m/01' )")
    .group("id").order("sum(order_details.quantity) DESC").limit(Settings.product.limit)}
  scope :get_lastest_product, ->(number){order(created_at: :desc).limit(number)}

  private

  def check_if_has_line_item
    if order_details.empty?
      true
    else
      errors.add(:base, Settings.error_destroy_product)
      false
    end
  end

  def self.import file
    spreadsheet = open_spreadsheet file
    if spreadsheet == Settings.unknown_file
      spreadsheet
    else
      header = spreadsheet.row(Settings.product_row)
      (Settings.product_start..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        product = find_or_initialize_by(name: row["name"])
        product.update_attributes(row.to_hash)
      end
    end
  end

  def self.open_spreadsheet file
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path, file_warning: :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, file_warning: :ignore)
    else Settings.unknown_file
    end
  end
end
