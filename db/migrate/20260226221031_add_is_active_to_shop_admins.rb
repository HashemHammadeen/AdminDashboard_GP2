class AddIsActiveToShopAdmins < ActiveRecord::Migration[8.1]
  def change
    add_column :shop_admins, :is_active, :boolean, default: true
  end
end
