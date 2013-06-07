class Spree::UpsWorldshipExport < ActiveRecord::Base

	attr_accessible	:order_number, :shipping_name, :shipping_address_id, :shipping_address1, :shipping_address2, :shipping_city, :shipping_state, :shipping_zipcode, :shipping_phone, :shipping_country, :shipping_method, :shipment_id, :shipment_number, :shipment_date, :shipment_weight_in_lbs

	def sync_with_shipment(shipment)
		order = shipment.order
		address = shipment.address

		service_code = shipment.shipping_method.calculator.service_code rescue nil
		packages = shipment.shipping_method.calculator.send(:packages, order)
		total_weight = packages.collect{|p| p.weight}.reduce(:+)
		total_weight_in_lbs = (total_weight / Spree::ActiveShipping::Config[:unit_multiplier]).round(2)

		attr = {
	 		:order_number => order.number,
	  	:shipment_number => shipment.number,
	  	:shipping_name => full_name(address),
	  	:shipping_address_id =>  address.id,
	  	:shipping_address1 => address.address1,
	  	:shipping_address2 => address.address2,
	  	:shipping_city => address.city,
	  	:shipping_state => address.state,
	  	:shipping_zipcode => address.zipcode,
	  	:shipping_phone => address.phone,
	  	:shipping_country => address.country,
	  	:shipping_method => service_code,
	  	:shipment_id => shipment.id,
	  	:shipment_weight_in_lbs => total_weight_in_lbs,
	  	:shipment_date => shipment.updated_at
	 	}

	 	update_attributes(attr)
	end

	def full_name(address)
		"#{address.firstname} #{address.lastname}"
	end

end
