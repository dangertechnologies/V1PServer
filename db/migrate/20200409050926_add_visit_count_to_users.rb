class AddVisitCountToUsers < ActiveRecord::Migration[6.0]
  def self.up
    add_column :users, :visit_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :users, :visit_count
  end
end
