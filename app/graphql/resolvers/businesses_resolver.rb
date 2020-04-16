class Resolvers::BusinessesResolver < Resolvers::BaseResolver
  # requires_authentication!
  type [Types::BusinessType], null: false

  def resolve
    # TODO: Resolve business by current_user
    # call your application logic here:
    context[:current_user].businesses.distinct
  end
end