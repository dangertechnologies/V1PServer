class AddAdminToInviteCode < ActiveRecord::Migration[6.0]
  def change
    add_reference :invite_codes, :admin, null: true, foreign_key: true
  end
end
