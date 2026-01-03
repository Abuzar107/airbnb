class AddDefaultToReviewsCountInProperties < ActiveRecord::Migration[8.0]
  def change
    change_column_default :properties, :reviews_count, 0
  end
end
