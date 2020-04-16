class Mutations::DeleteUser < Mutations::BaseMutation
  requires_authentication!
  null true

  argument :id, Integer, required: true

  field :user, Types::UserType, null: true
  field :errors, [String], null: false

  def resolve(id: nil)
    user = User.find(id)
    
    if busines.destroy
      # Successful creation, return the created object with no errors
      {
        user: user,
        errors: [],
      }
    else
      # Failed save, return the errors to the client
      {
        user: nil,
        errors: user.errors.full_messages
      }
    end
  end
end