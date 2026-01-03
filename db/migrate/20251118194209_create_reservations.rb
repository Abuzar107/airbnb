class CreateReservations < ActiveRecord::Migration[8.0]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :property, null: false, foreign_key: true
      t.date :checkin_data
      t.date :checkout_date

      t.timestamps
    end

    add_index :reservations, [ :user_id, :property_id, :checkin_data, :checkout_date], unique: true
  end
end
