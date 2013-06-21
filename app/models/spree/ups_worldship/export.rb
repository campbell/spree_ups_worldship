# Currently we only handle a single package with the shipment ID as the identifier. This is because Spree::ActiveShipping
# does not keep track of packages (the only notion of packages is when Spree is calculating the shipment pricing). Since
# there are no package records, we cannot create individual packages with their own tracking information, so we simply
# pretend that there is a single package (which is probably true 99% of the time)
# In order to accurately handle multiple packages per shipment, the sync_with_shipment method needs to be changed to create
# a record for every package and use the package ID as the unique identifier in Worldship (so the tracking number can be
# saved later).

class Spree::UpsWorldship::Export < ActiveRecord::Base

  self.table_name = 'spree_upsworldship_exports'

  attr_accessible :order_number, :shipping_name, :shipping_address_id, :shipping_address1, :shipping_address2, :shipping_city, :shipping_state, :shipping_zipcode, :shipping_phone, :shipping_country, :shipping_method, :shipment_id, :shipment_number, :shipment_date, :shipment_weight_in_lbs

end
