# Currently we only handle a single package with the shipment ID as the identifier. This is because Spree::ActiveShipping
# does not keep track of packages (the only notion of packages is when Spree is calculating the shipment pricing). Since
# there are no package records, we cannot create individual packages with their own tracking information, so we simply
# pretend that there is a single package (which is probably true 99% of the time)
# In order to accurately handle multiple packages per shipment, the sync_with_shipment method needs to be changed to create
# a record for every package and use the package ID as the unique identifier in Worldship (so the tracking number can be
# saved later).

class Spree::UpsWorldship::Shipment

  DEFAULT_FLAT_RATE_SERVICE_CODE = 'GND'

  # TODO - This model should be split into a new model that contains the shipment info and then writes out an Export record
  def initialize(shipment)
    @shipment = shipment
  end

  def shipment
    @shipment
  end

  # Create / update a record for every shipment. UPS WorldShip can then access this table to get the shipment/package
  # information and later send back the tracking number.
  def sync_with_shipment

    address = shipment.address
    order = shipment.order

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
      :shipment_weight_in_lbs => total_weight,
      :shipment_date => shipment.updated_at
    }

    export = Spree::UpsWorldship::Export.find_by_shipment_id(shipment.id) || Spree::UpsWorldship::Export.new

    export.update_attributes(attr)
  end

  def calculator
    shipment.shipping_method.calculator
  end

  def service_code
    calculator.respond_to?(:service_code) ? calculator.service_code : DEFAULT_FLAT_RATE_SERVICE_CODE
  end

  def packages
    order = shipment.order
    shipment.shipping_method.calculator.send(:packages, order) rescue []
  end

  def package_weights # in lbs
    packages.collect{|p| (p.weight / Spree::ActiveShipping::Config[:unit_multiplier]).round(2)}
  end

  def total_weight
    weight = package_weights.reduce(:+) || shipment.inventory_units.collect{|i| i.quantity * i.variant.weight.to_f}.reduce(:+)
  end



  def full_name(address)
    "#{address.firstname} #{address.lastname}"
  end

end
