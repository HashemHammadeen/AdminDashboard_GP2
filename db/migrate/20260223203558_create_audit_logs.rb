class CreateAuditLogs < ActiveRecord::Migration[8.1]
  def change
    create_table :audit_logs, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true, null: true
      t.references :shop, type: :uuid, foreign_key: true, null: true

      t.uuid :admin_id, index: true, comment: 'ID of the mall_admin or shop_admin who performed the action'
      t.string :admin_type, comment: 'mall_admin or shop_admin'
      t.string :action_type, null: false, comment: 'e.g., manual_adjustment, tier_change, config_update'
      t.integer :points, comment: 'The number of points changed, if applicable'
      t.jsonb :metadata, comment: 'Extra details about the change'

      t.timestamps
    end
  end
end