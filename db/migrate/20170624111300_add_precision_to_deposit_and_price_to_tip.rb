class AddPrecisionToDepositAndPriceToTip < ActiveRecord::Migration[5.0]
  def change
    add_column :tips,         :price,   :decimal, precision: 5, scale: 2
    change_column :deposits,  :amount,  :decimal, precision: 5, scale: 2
  end
end
