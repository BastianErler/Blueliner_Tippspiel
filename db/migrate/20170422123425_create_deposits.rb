class CreateDeposits < ActiveRecord::Migration[5.0]
  def change
    create_table :deposits do |t|
      t.integer :user_id
      t.integer :creater_id
      t.decimal :amount
      t.string  :comment

      t.timestamps
    end
  end
end
