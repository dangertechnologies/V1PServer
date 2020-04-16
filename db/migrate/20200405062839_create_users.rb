class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :avatar
      t.string :card_number
      t.references :tier, null: false, foreign_key: true
      t.boolean :is_enabled

      t.timestamps
    end
  end
end
