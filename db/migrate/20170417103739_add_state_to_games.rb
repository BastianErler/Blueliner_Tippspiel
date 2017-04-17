class AddStateToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :state, :string, default: 'open'
    add_column :games, :current, :boolean, default: false
    add_column :games, :evaluated, :boolean, default: false
  end
end
