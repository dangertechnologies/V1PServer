# == Schema Information
#
# Table name: tiers
#
#  id          :integer          not null, primary key
#  business_id :integer          not null
#  name        :string
#  color       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Tier < ApplicationRecord
  belongs_to :business
  has_many :users, dependent: :destroy
end
