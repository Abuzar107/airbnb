class AddIndexToReservations < ActiveRecord::Migration[8.0]
  def change
     add_index :reservations, [:user_id, :property_id, :checkin_data, :checkout_date], unique: true, name: "add_index_to_reservations"
  end
end
