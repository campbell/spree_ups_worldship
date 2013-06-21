class ChangeShipmentExportTableName < ActiveRecord::Migration
  def up
  	return if table_exists?(:spree_upsworldship_exports)
  	rename_table :spree_ups_worldship_exports, :spree_upsworldship_exports
  end

  def down
    return if table_exists?(:spree_ups_worldship_exports)
    rename_table :spree_upsworldship_exports, :spree_ups_worldship_exports
  end
end
