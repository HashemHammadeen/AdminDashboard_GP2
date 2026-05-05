class MakeUserAndShopNullableInQrs < ActiveRecord::Migration[8.1]
  def change
    change_column_null :qrs, :user_id, true
    change_column_null :qrs, :shop_id, true
  end
end
