class CreateTips < ActiveRecord::Migration[5.0]
  def change
    create_table :tips do |t|
      t.integer   :game_id
      t.integer   :user_id
      t.integer   :home_goals
      t.integer   :away_goals

      t.timestamps
    end
    add_index :tips, [:game_id, :user_id]
  end
end
