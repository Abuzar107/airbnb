module Owner
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :set_property, only: [ :edit, :update, :update_amenities, :add_images, :remove_image, :destroy ]

    def new
      @property = Property.new
    end

    def create
      @property = current_user.properties.create!(property_params)
      redirect_to edit_owner_property_path(@property), notice: "Property added successfully"
    end

    def index
      @properties = current_user.properties.order(created_at: :desc)
    end

    def update
      if @property.update!(property_params)
        redirect_to edit_owner_property_path, notice: "property updated Successfully"
      else
        redirect_to fallback_location: edit_owner_property_path, alert: "Failed to update property"
      end
    end

    def update_amenities
      if @property.update!(amenities_params)
        redirect_to edit_owner_property_path, notice: "Amenities updated Successfully"
      else
        redirect_to fallback_location: edit_owner_property_path, alert: "Failed to update Amenities"
      end
    end

    def add_images
      if params[:property][:images].present?
        @property.images.attach(params[:property][:images])
        redirect_to edit_owner_property_path, notice: "Property images uploaded"
      else
        redirect_to edit_owner_property_path, alert: "No images uploaded"
      end
    end

    def remove_image
      image = @property.images.find(params[:image_id])
      if image.destroy!
        redirect_to edit_owner_property_path, notice: "Image deleted Successfully"
      else
        redirect_to fallback_location: edit_owner_property_path, alert: "Failed to delete image"
      end
    end

    def destroy
      @property.destroy
      redirect_to owner_property_path, alert: "#{@property.name} deleted successfully"
    end

    private

    def set_property
      @property = current_user.properties.find(params[:id])
    end

    def amenities_params
      params.require(:property).permit(:amenity_id => [])
    end

    def property_params
      params.require(:property).permit(
      :name,
      :price,
      :headline,
      :description,
      :guest_count,
      :bedroom_count,
      :bed_count,
      :bathroom_count,
      :address_1,
      :address_2,
      :city,
      :state,
      :country_code
      )
    end
  end
end