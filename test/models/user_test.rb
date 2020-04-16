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
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
