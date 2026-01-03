module Owner
  class ReservationsController < ApplicationController
    before_action :authenticate_user!
    def show
      @reservations = current_user.properties.map(&:reservations).flatten
    end
  end
end