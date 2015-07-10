class AddNightShiftToShifts < ActiveRecord::Migration
  def change
    add_column :shifts, :night_shift, :string
  end
end
