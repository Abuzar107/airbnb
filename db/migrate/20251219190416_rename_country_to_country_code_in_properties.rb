class RenameCountryToCountryCodeInProperties < ActiveRecord::Migration[8.0]
  def change
    rename_column :properties, :country, :country_code
  end
end
