class AddReservationIdToReviews < ActiveRecord::Migration[8.0]
  def change
    add_reference :reviews, :reservation, null: false, foreign_key: true
  end
end
