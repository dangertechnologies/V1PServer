# == Schema Information
#
# Table name: identities
#
#  id            :integer          not null, primary key
#  admin_id      :integer          not null
#  provider      :string
#  uid           :string
#  token         :string
#  token_expires :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'test_helper'

class IdentityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
