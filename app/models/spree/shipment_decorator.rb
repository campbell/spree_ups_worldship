module Spree
	Shipment.class_eval do
		has_one :ups_worldship_export
		after_save :update_worldship

		def update_worldship
			export = ups_worldship_export || Spree::UpsWorldship::Shipment.new(self)
			export.sync_with_shipment
		end

	end
end