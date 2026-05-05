class RenameMallNameToName < ActiveRecord::Migration[8.1]
  def change
    remove_index :malls, :mall_name if index_exists?(:malls, :mall_name)
    rename_column :malls, :mall_name, :name
  end
end
