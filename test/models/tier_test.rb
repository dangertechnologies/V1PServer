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
require 'test_helper'

class TierTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
