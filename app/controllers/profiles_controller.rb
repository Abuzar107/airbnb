class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile

  def update
    if @profile.update!(profile_params)
      redirect_to edit_profile_path, notice: "Profile updated Successfully"
    else
      redirect_to fallback_location: root_path, alert: "Failed to update profile"
    end
  end

  private

  def set_profile
    @profile = current_user.profile
  end

  def profile_params
    params.require(:profile).permit(
      :name,
      :address_1,
      :address_2,
      :city,
      :state,
      :country_code
    )
  end
end