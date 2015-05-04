class CreateTshirts < ActiveRecord::Migration
  def change
   create_table :tshirts do |t|
      t.float :price
  	  t.string :size
  	  t.string :country
  	  t.string :club
      t.integer :manufacturer_id, :null => false
  	end
      execute 'ALTER TABLE tshirts ADD CONSTRAINT fk_man_manufacturer FOREIGN KEY ( manufacturer_id ) REFERENCES manufacturers( id ) ON DELETE CASCADE'
 	end
  end
