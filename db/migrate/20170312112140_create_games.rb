class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer   :game_number
      t.integer   :home_team_id
      t.integer   :away_team_id
      t.datetime  :game_date
      t.integer   :home_goals
      t.integer   :away_goals
      t.integer   :season_id

      t.timestamps
    end
    add_index :games, [:season_id]
  end
end
