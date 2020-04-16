class CreateInviteCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :invite_codes do |t|
      t.string :code
      t.references :business, null: false, foreign_key: true

      t.timestamps
    end
  end
end
