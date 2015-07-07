class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
    	t.date :start_date
    	t.date :end_date
    	t.string :schedule_name
      	t.timestamps null: false
    end
  end
end
