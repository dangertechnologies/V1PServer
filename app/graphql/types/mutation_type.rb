class Types::MutationType < Types::BaseObject

  field :authenticate, null: false, resolver: Mutations::AuthenticateAdmin,
  description: "Authenticate admin"

  field :create_user, null: false, resolver: Mutations::CreateUser,
  description: "Create user"

  field :update_user, null: false, resolver: Mutations::UpdateUser,
  description: "Update user"

  field :create_business, null: false, resolver: Mutations::CreateBusiness,
  description: "Create a new business"

  field :update_business, null: false, resolver: Mutations::UpdateBusiness,
  description: "Update a business"

  field :join_business, null: false, resolver: Mutations::JoinBusiness,
  description: "Join a business by invite code"

  field :delete_business, null: false, resolver: Mutations::DeleteBusiness,
  description: "Delete a business"

  field :create_visit, null: false, resolver: Mutations::CreateVisit,
  description: "Check a user in and increment visit count"
end
