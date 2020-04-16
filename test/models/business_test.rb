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
require 'test_helper'

class BusinessTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
