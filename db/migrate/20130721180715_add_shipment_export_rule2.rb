class AddShipmentExportRule2 < ActiveRecord::Migration
  RULE_NAME = 'update_order_shipping_state'
  TABLE_NAME = 'spree_ups_shipment'

  def up
    create_rule_sql = "CREATE OR REPLACE RULE #{RULE_NAME} AS
      ON INSERT TO #{TABLE_NAME} DO INSTEAD
      UPDATE spree_orders SET shipment_state = 'shipped'::character varying FROM spree_shipments 
      WHERE spree_shipments.id = new.shipment_id AND spree_orders.id = spree_shipments.order_id
        AND (
          select count(*) from spree_shipments where order_id = ( select order_id from spree_shipments where id = new.shipment_id) and state <> 'shipped'
        ) = 0;"
    execute(create_rule_sql)
  end

  def down
    drop_rule_sql = "DROP RULE #{RULE_NAME} ON #{TABLE_NAME}"
    execute(drop_rule_sql)
  end
end


