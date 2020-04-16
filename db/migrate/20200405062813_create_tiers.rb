class CreateTiers < ActiveRecord::Migration[6.0]
  def change
    create_table :tiers do |t|
      t.references :business, null: false, foreign_key: true
      t.string :name
      t.string :color
      t.text :description

      t.timestamps
    end
  end
end
