class AddShipmentExportRule < ActiveRecord::Migration
  RULE_NAME = 'spree_ups_shipment'
  TABLE_NAME = 'spree_ups_shipment'

  def up
    create_rule_sql = "CREATE OR REPLACE RULE #{RULE_NAME} AS
      ON INSERT TO #{TABLE_NAME} DO INSTEAD
      UPDATE spree_shipments SET tracking = new.shipment_tracking_number, cost = new.shipment_cost,
      shipped_at = new.ship_date, state = 'shipped'::character varying
      WHERE spree_shipments.id = new.shipment_id;"
    execute(create_rule_sql)
  end

  def down
    drop_rule_sql = "DROP RULE #{RULE_NAME} ON #{TABLE_NAME}"
    execute(drop_rule_sql)
  end
end
