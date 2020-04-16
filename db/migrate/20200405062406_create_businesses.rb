class CreateBusinesses < ActiveRecord::Migration[6.0]
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :address
      t.string :phone_number
      t.string :description
      t.boolean :is_enabled
      t.boolean :is_subscribed
      t.datetime :last_payment_at

      t.timestamps
    end
  end
end
