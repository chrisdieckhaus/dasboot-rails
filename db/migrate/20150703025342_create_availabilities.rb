class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.date :day_date
      t.string :times
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
