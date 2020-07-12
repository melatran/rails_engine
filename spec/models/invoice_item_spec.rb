require 'rails_helper'

describe InvoiceItem do
  describe "validations" do
    it {should validate_presence_of :unit_price}
    it {should validate_presence_of :quantity}
  end

  describe "relationships" do
    it {should belong_to :item}
    it {should belong_to :invoice}
  end
end
