module Spree
	Shipment.class_eval do
#		has_one :export, :class_name => 'Spree::UpsWorldship::Export'
		after_save :update_worldship
		before_destroy :purge_worldship

		def update_worldship
			exported_shipment = Spree::UpsWorldship::Shipment.new(self)
			exported_shipment.sync_with_shipment
		end

		def purge_worldship
			Spree::UpsWorldship::Export.destroy_all(shipment_number: self.number)
		end

	end
end