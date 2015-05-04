require File.dirname(__FILE__) + '/../test_helper'

class TshirtTest < ActiveSupport::TestCase
  test "validates_presence_of_manufacturer" do
   	tshirt = Tshirt.create(:manufacturer_id => 1, :size => 'L', :club => 'Madrid', :country => 'Spain')
   	tshirt.manufacturer_id = nil
   	assert !tshirt.valid?
   end

   test "validates_presence_of_size" do
   	tshirt = Tshirt.create(:manufacturer_id => 1, :size => 'L', :club => 'Madrid', :country => 'Spain')
   	tshirt.size = nil
   	assert !tshirt.valid?
   end

   test "validates_presence_of_club" do
   	tshirt = Tshirt.create(:manufacturer_id => 1, :size => 'L', :club => 'Madrid', :country => 'Spain')
   	tshirt.club = nil
   	assert !tshirt.valid?
   end

   test "validates_presence_of_country" do
   	tshirt = Tshirt.create(:manufacturer_id => 1, :size => 'L', :club => 'Madrid', :country => 'Spain')
   	tshirt.country = nil
   	assert !tshirt.valid?
   end

   test "belongs_to_mapping" do
   	manufacturer = Manufacturer.find_by_id(1)
   	tshirt = Tshirt.create(:manufacturer => manufacturer, :size => 'L', :club => 'Madrid', :country => 'Spain')

   	assert_equal 1, tshirt.manufacturer.id
   end
end