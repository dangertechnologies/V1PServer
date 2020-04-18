class Mutations::JoinBusiness < Mutations::BaseMutation
  requires_authentication!
  null true

  argument :invite_code, String, required: true

  field :business, Types::BusinessType, null: true
  field :errors, [String], null: false

  def resolve(invite_code: nil)
    code = InviteCode.find_by(code: invite_code)
    code.admin_id = context[:current_user].id
    

    code.save!
    # Successful creation, return the created object with no errors
    {
      business: code.business,
      errors: [],
    }
    
  rescue CanCan::AccessDenied => exception
    {
      business: nil,
      errors: [exception.message]
    }
  rescue ActiveRecord::RecordInvalid => invalid
    # Failed save, return the errors to the client
    {
      business: nil,
      errors: invalid.record.errors.full_messages
    }
  rescue ActiveRecord::RecordNotSaved => error
    # Failed save, return the errors to the client
    {
      business: nil,
      errors: invalid.record.errors.full_messages
    }
  rescue ActiveRecord::RecordNotFound => error
    {
      business: nil,
      errors: [ error.message ]
    }
  end
end