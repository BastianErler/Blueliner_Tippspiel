class AddMoneyToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :sum_money_in,   :decimal
    add_column :users, :sum_money_out,  :decimal
  end
end
