require "rails_helper"

RSpec.describe Product, type: :model do
  let(:product) {FactoryGirl.create :product}
  subject {product}
  let(:category) {FactoryGirl.create :category}

  context "associations" do
    it {is_expected.to belong_to :category}
    it {is_expected.to have_many :order_details}
    it {is_expected.to have_many :ratings}
    it {is_expected.to have_many :comments}
  end

  context "validates" do
    it {is_expected.to validate_presence_of :name}
    it {is_expected.to validate_presence_of :price}
    it {is_expected.to validate_presence_of :quantity}
    it {is_expected.to validate_numericality_of(:quantity).is_greater_than_or_equal_to(0)}
  end

  context "columns" do
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:price).of_type(:integer)}
    it {is_expected.to have_db_column(:quantity).of_type(:integer)}
    it {is_expected.to have_db_column(:category_id).of_type(:integer)}
  end

  context "when name is not valid" do
    before {subject.name = ""}
    it "matches the error message" do
      subject.valid?
      subject.errors[:name].should include("can't be blank")
    end
  end

  context "when price is not valid" do
    before {subject.price = ""}
    it "matches the error message" do
      subject.valid?
      subject.errors[:price].should include("can't be blank")
    end
  end


  context "when quantity is not valid" do
    before {subject.quantity = ""}
    it "matches the error message" do
      subject.valid?
      subject.errors[:quantity].should include("can't be blank")
    end
  end

  context "When quantity is less than 0" do
    before {subject.quantity = -1}
    it "matches the error message" do
      subject.valid?
      subject.errors[:quantity].should include("must be greater than or equal to 0")
    end
  end

end
