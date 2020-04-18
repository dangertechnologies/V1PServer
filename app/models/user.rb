# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  first_name  :string
#  last_name   :string
#  phone       :string
#  card_number :string
#  tier_id     :integer          not null
#  is_enabled  :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  visit_count :integer          default(0), not null
#
class User < ApplicationRecord
  include ActiveStorageSupport::SupportForBase64
  belongs_to :tier
  has_one_base64_attached :avatar
  has_many :visits
  counter_culture :tier, column_name: "user_count"
end
