class AddReactivationFieldsToOffers < ActiveRecord::Migration[8.1]
  def change
    add_column :offers, :inactive_by_mall_admin, :boolean, default: false
    add_column :offers, :reactivation_requested, :boolean, default: false
  end
end
