class AddDefaultToAverageFinalRatingInProperties < ActiveRecord::Migration[8.0]
  def change
    change_column_default :properties, :average_final_rating, 0
  end
end
