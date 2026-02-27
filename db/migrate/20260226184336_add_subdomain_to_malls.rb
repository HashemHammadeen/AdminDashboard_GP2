class AddSubdomainToMalls < ActiveRecord::Migration[8.1]
  def change
    add_column :malls, :subdomain, :string
    add_index :malls, :subdomain, unique: true
  end
end
