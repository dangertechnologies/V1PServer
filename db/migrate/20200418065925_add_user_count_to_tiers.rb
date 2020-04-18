class AddUserCountToTiers < ActiveRecord::Migration[6.0]
  def self.up
    add_column :tiers, :user_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :tiers, :user_count
  end
end
