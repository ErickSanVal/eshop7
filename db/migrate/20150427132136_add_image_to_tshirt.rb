class AddImageToTshirt < ActiveRecord::Migration
  def up
    add_attachment :tshirts, :image
  end

  def down
    remove_attachment :tshirts, :image
  end
end
