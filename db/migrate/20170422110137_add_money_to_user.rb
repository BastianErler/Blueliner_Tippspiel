class AddMoneyToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :sum_money_in,   :decimal, default: 0
    add_column :users, :sum_money_out,  :decimal, default: 0
  end
end
