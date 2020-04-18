class Mutations::DeleteUser < Mutations::BaseMutation
  requires_authentication!
  null true

  argument :id, Integer, required: true

  field :user, Types::UserType, null: true
  field :errors, [String], null: false

  def resolve(id: nil)
    user = User.find(id)
    
    user.destroy!
    
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