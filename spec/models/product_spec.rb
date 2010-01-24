require 'spec_helper'

describe Product do
  before(:each) do
    @valid_attributes = {
      :farm_id => 1,
      :name => "Extra Large Chicken"
    }
  end

  it "should create a new instance given valid attributes" do
    Product.create!(@valid_attributes)
  end
end
