class RemoveTimesFromAvailabilitiesTable < ActiveRecord::Migration
  def down
    remove_column :availabilities, :times
  end
end
