class AddSubRequestToShifts < ActiveRecord::Migration
  def change
  	add_column :shifts, :sub_request, :string, default: '0'
  end
end
