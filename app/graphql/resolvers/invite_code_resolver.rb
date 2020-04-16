class Resolvers::InviteCodeResolver < Resolvers::BaseResolver
  # requires_authentication!
  type Types::InviteCodeType, null: false
  argument :business_id, Integer, required: true,
  description: "Organization ID to fetch for"

  def resolve(business_id: nil)
    # TODO: Resolve business by current_user
    # call your application logic here:
    if context[:current_user]
      business = context[:current_user].businesses.find(business_id)

      last_invite_code = business.invite_codes.last

      if last_invite_code && last_invite_code.admin.nil?
        last_invite_code
      else
        business.invite_codes.create!
      end
    end
  end
end