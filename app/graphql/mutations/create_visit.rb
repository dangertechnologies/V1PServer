class Mutations::CreateVisit < Mutations::BaseMutation
  requires_authentication!
  null true

  argument :user_id, Integer, required: true

  field :user, Types::UserType, null: true
  field :errors, [String], null: false

  def resolve(user_id: nil)
    
    user = User.find(user_id)
    
    user.visits.create!
    
    # Successful creation, return the created object with no errors
    {
      user: user,
      errors: [],
    }
  end
end