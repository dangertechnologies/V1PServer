class Resolvers::BusinessResolver < Resolvers::BaseResolver
  # requires_authentication!
  type Types::BusinessType, null: false
  argument :id, Integer, required: true,
  description: "Organization ID to fetch info for"

  def resolve(id: nil)
    # TODO: Resolve business by current_user
    # call your application logic here:
    context[:current_user].businesses.find(id) if context[:current_user]
  end
end