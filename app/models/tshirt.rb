class Tshirt < ActiveRecord::Base
	belongs_to :manufacturer
	has_many :cart_items
  	has_many :carts, :through => :cart_items

	validates_presence_of :manufacturer, :size, :club, :country, :price
	validates_numericality_of :price
  has_attached_file :image, styles: { :medium => "125x125>", :thumb => "35x35>" }
  validates_attachment :image,
  :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }

  def self.latest(num)
    all.order("tshirts.id desc").includes(:manufacturer).limit(num)
  end
end