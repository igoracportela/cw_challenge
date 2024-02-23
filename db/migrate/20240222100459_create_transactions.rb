class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.integer :transaction_id, null: false, index: true
      t.integer :merchant_id, null: false, index: false
      t.integer :user_id, null: false, index: true
      t.string :card_number, null: false, index: false
      t.datetime :transaction_date, null: false, index: false
      t.integer :transaction_amount, null: false, index: false
      t.integer :device_id, null: false, index: true

      t.timestamps
    end
  end
end
