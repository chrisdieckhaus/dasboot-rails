class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.date :date
      t.datetime :start_time
      t.datetime :end_time
      
      t.user :references, index: true, foreign_key: true
      t.schedule :references, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
