# == Schema Information
#
# Table name: admins
#
#  id             :integer          not null, primary key
#  name           :string
#  phone          :string
#  invite_code_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Admin < ApplicationRecord
  has_many :invite_codes
  has_many :businesses, through: :invite_codes

  def self.from_token_request request
    # Returns a valid user, `nil` or raise `Knock.not_found_exception_class_name`
    # e.g.
    #   email = request.params["auth"] && request.params["auth"]["email"]
    #   self.find_by email: email
    puts request.params.to_h
  end
end
