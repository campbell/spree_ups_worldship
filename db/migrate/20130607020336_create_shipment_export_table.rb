class CreateShipmentExportTable < ActiveRecord::Migration
  def up

  	return if table_exists?(:spree_ups_worldship_exports)

  	create_table :spree_ups_worldship_exports do |t|
  		t.string :order_number
  		t.string :shipment_number
  		t.string :shipping_name
  		t.string :shipping_address1
  		t.string :shipping_address2
  		t.string :shipping_city
  		t.string :shipping_state
  		t.string :shipping_zipcode
  		t.string :shipping_phone
  		t.string :shipping_country
  		t.string :shipping_method
  		t.references :shipping_address
  		t.references :shipment
  		t.float :shipment_weight_in_lbs
  		t.datetime :shipment_date
  		t.timestamps
  	end
  end

  def down
  	drop_table :spree_ups_worldship_exports
  end
end
