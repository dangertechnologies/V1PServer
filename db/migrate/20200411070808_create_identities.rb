class CreateIdentities < ActiveRecord::Migration[6.0]
  def change
    create_table :identities do |t|
      t.references :admin, null: false, foreign_key: true
      t.string :provider
      t.string :uid
      t.string :token
      t.datetime :token_expires

      t.timestamps
    end
  end
end
