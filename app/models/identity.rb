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
require "open-uri"

class Identity < ApplicationRecord
  belongs_to :admin
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider


  def self.from_google(token: nil)
    begin
      payload = GoogleIDToken::Validator.new.check(
        token,
        ENV["GOOGLE_CLIENT_ID"]
      )
    rescue GoogleIDToken::AudienceMismatchError
      payload = GoogleIDToken::Validator.new.check(
        token,
        ENV["GOOGLE_CLIENT_ID"]
      )
    end
    
    identity = find_for_app_auth(
      uid: payload["sub"],
      provider: :GOOGLE
    )

    if identity.admin.nil?
      
      u = Admin.create!(
        name: payload["given_name"],
      )

      identity.update_attributes!(admin: u)
    end

    identity
  end

  def self.find_for_app_auth(uid: nil, provider: nil)
    if identity = Identity.find_by(provider: provider, uid: uid)
      identity
    else
      create(
        uid: uid,
        provider: provider,
      )
    end
  end
end
