module Types
  class QueryType < Types::BaseObject


    field :users, resolver: ::Resolvers::UsersResolver
    field :user, resolver: ::Resolvers::UserResolver
    field :current_admin, resolver: ::Resolvers::CurrentAdminResolver
    field :business, resolver: ::Resolvers::BusinessResolver
    field :businesses, resolver: ::Resolvers::BusinessesResolver
    field :invite_code, resolver: ::Resolvers::InviteCodeResolver
  end
end
