class RenameShopsPrimaryKey < ActiveRecord::Migration[8.1]
  def change
    rename_column :shops, :id, :shop_id if column_exists?(:shops, :id)
    rename_column :system_configs, :id, :config_id if column_exists?(:system_configs, :id)

    # Preserve UUID defaults — rename_column can drop them in some PG setups
    execute "ALTER TABLE shops ALTER COLUMN shop_id SET DEFAULT gen_random_uuid()" if column_exists?(:shops, :shop_id)
    execute "ALTER TABLE system_configs ALTER COLUMN config_id SET DEFAULT gen_random_uuid()" if column_exists?(:system_configs, :config_id)
  end
end
