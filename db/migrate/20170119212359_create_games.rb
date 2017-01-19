class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.date :date_played

      t.timestamps null: false
    end
  end
end
