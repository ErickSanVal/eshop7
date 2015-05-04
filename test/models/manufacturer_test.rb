require File.dirname(__FILE__) + '/../test_helper'

class ManufacturerTest < ActiveSupport::TestCase
  test "test_name" do
    manufacturer = Manufacturer.create(:name => 'Fabricante', :telephone => '123321123')
    assert_equal 'Fabricante', manufacturer.name
  end

  test "test_telephone" do
  	manufacturer = Manufacturer.create(:name => 'Fabricante2', :telephone => '123321113')
    assert_equal '123321113', manufacturer.telephone
   end

   test "validates_presence_of_name" do
   	manufacturer = Manufacturer.create(:name => 'Fabricante3', :telephone => '1233211123')
   	manufacturer.name = nil
   	assert !manufacturer.valid?
   end

   test "validates_presence_of_telephone" do
   	manufacturer = Manufacturer.create(:name => 'Fabricante4', :telephone => '1233211123')
   	manufacturer.telephone = nil
   	assert !manufacturer.valid?
   end
end