class AddTimesToAvailabilities < ActiveRecord::Migration
  def change
  	add_column :availabilities, :times, :string
  end
end
