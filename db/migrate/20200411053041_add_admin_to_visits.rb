class AddAdminToVisits < ActiveRecord::Migration[6.0]
  def change
    add_reference :visits, :admin, null: true, foreign_key: true
  end
end
