class RemoveFieldsFromAvailabilities < ActiveRecord::Migration
  def change
  	remove_column :availabilities, :day_date
  	remove_column :availabilities, :times
  end
end
