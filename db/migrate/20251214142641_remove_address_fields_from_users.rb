class RemoveAddressFieldsFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :name, :string
    remove_column :users, :address_1, :string
    remove_column :users, :address_2, :string
    remove_column :users, :city, :string
    remove_column :users, :state, :string
    remove_column :users, :country, :string
  end
end
