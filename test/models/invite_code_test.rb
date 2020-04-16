# == Schema Information
#
# Table name: invite_codes
#
#  id          :integer          not null, primary key
#  code        :string
#  business_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  admin_id    :integer
#
require 'test_helper'

class InviteCodeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
