module Spree
	Shipment.class_eval do
		has_one :export, :class_name => 'Spree::UpsWorldship'
		after_save :update_worldship

		def update_worldship
			exported_shipment = export || Spree::UpsWorldship::Shipment.new(self)
			exported_shipment.sync_with_shipment
		end

	end
end