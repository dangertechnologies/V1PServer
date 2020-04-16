class Resolvers::UsersResolver < Resolvers::BaseResolver
  type Types::UserType.connection_type, null: false

  argument :business_id, Integer, required: false
  argument :search, String, required: false

  def resolve(business_id: nil, search: nil)
    # call your application logic here:
    User.joins(tier: [:business]).where(tiers: { business: Business.find(business_id) })
  end
end