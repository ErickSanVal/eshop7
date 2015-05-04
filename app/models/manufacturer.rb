class Manufacturer < ActiveRecord::Base
    has_many :tshirts
	validates_presence_of :name, :telephone
end
