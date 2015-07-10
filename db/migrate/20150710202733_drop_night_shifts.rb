class DropNightShifts < ActiveRecord::Migration
  def change
  	drop_table :night_shifts
  end
end
