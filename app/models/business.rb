# == Schema Information
#
# Table name: businesses
#
#  id              :integer          not null, primary key
#  name            :string
#  address         :string
#  phone_number    :string
#  description     :string
#  is_enabled      :boolean
#  is_subscribed   :boolean
#  last_payment_at :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Business < ApplicationRecord
  include ActiveStorageSupport::SupportForBase64
  has_many :tiers, dependent: :destroy
  has_many :users, through: :tiers
  has_many :invite_codes, dependent: :destroy
  after_create :default_setup
  has_one_base64_attached :logo


  def default_setup
    tiers.create!(
      name: "Member",
      color: "#3333E9"
    )
  end
end
