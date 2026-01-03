class BookingsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @property = Property.find(params[:property_id])

    @checkin_date = Date.parse(params[:checkin_data])  if params[:checkin_data].present?
    @checkout_date = Date.parse(params[:checkout_date]) if params[:checkout_date].present?

    @total_nights = numberOfNights

    @per_night = @property.price
    @base_fare = @property.price * @total_nights
    @service_fee = @base_fare * 0.18
    @total_amount = @base_fare + @service_fee
  end


  private

  def numberOfNights
    checkinDate = Date.parse(params[:checkin_data])
    checkoutDate = Date.parse(params[:checkout_date])
    return (checkoutDate - checkinDate).to_i
  end

  def booking_params
    params.permit(:property_id, :checkin_data, :checkout_date)
  end
end