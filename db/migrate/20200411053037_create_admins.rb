class CreateAdmins < ActiveRecord::Migration[6.0]
  def change
    create_table :admins do |t|
      t.string :name
      t.string :phone
      t.references :invite_code, null: true, foreign_key: true

      t.timestamps
    end
  end
end
