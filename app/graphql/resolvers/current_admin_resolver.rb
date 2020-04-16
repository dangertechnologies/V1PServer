class Resolvers::CurrentAdminResolver < Resolvers::BaseResolver
  requires_authentication!
  type Types::AdminType, null: true


  def resolve
    context[:current_user]
  end
end