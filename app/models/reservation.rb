class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :property

  has_one :payment, dependent: :destroy
  belongs_to :review, dependent: :destroy

  validates :checkin_data, presence: :true
  validates :checkout_date, presence: :true

  scope :upcoming_reservations, -> { where("checkin_data > ?", Date.today).order(:checkin_data) }
  scope :current_reservations, -> { where("checkout_date > ?", Date.today).where("checkin_data < ?", Date.today).order(:checkout_date) }
  scope :overlapping_reservation, ->(checkin_data, checkout_date) {
    where(
        "(checkin_data < ? AND checkout_date > ?) OR
        (checkin_data < ? AND checkout_date > ?) OR
        (checkin_data > ? AND checkout_date < ?) OR
        (checkin_data < ? AND checkout_date > ?)",
        checkin_data, checkin_data,
        checkout_date, checkout_date,
        checkin_data, checkout_date,
        checkin_data, checkout_date,
      )
  }
end
