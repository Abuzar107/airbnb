class RenameCountryToCountryCodeInProfiles < ActiveRecord::Migration[8.0]
  def change
    rename_column :profiles, :country, :country_code
  end
end
