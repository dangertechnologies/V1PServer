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

  rescue CanCan::AccessDenied => exception
    {
      user: nil,
      errors: [exception.message]
    }
  rescue ActiveRecord::RecordInvalid => invalid
    # Failed save, return the errors to the client
    {
      user: nil,
      errors: invalid.record.errors.full_messages
    }
  rescue ActiveRecord::RecordNotSaved => error
    # Failed save, return the errors to the client
    {
      user: nil,
      errors: invalid.record.errors.full_messages
    }
  rescue ActiveRecord::RecordNotFound => error
    {
      user: nil,
      errors: [ error.message ]
    }
  end
end