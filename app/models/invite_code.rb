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
class InviteCode < ApplicationRecord
  belongs_to :business
  belongs_to :admin, optional: true

  before_validation do
    code = ('a'..'z').to_a.shuffle[0,8].join.upcase

    while InviteCode.exists?(code: code)
      code = ('A'..'Z').to_a.shuffle[0, 8].join.upcase
    end
    assign_attributes(code: code)
  end
end
