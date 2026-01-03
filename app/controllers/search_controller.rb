class SearchController < ApplicationController
  def index
    if are_all_params_empty?
      redirect_to root_path
    end
    @properties = Property.all

    if serach_params[:country_code].present?
      @properties = @properties.where(country_code: serach_params[:country_code])
    end
    if serach_params[:checkin_data].present? && serach_params[:checkout_date].present?
      @properties = @properties.with_reservation_overlap(serach_params[:checkin_data], serach_params[:checkout_date])
    end
  end

  private

  def are_all_params_empty?
    !serach_params[:county_code].present? && !serach_params[:checkin_data].present? && !serach_params[:checkout_date].present? 
  end

  def serach_params
    params.permit(:county_code, :checkin_data, :checkout_date)
  end
end