class Mutations::DeleteTier < Mutations::BaseMutation
  requires_authentication!
  null true

  argument :id, Integer, required: true

  field :business, Types::BusinessType, null: true
  field :errors, [String], null: false

  def resolve(id: nil)
    tier = Tier.where(
      business: context[:current_user].businesses
    ).find_by(id: id)
    
    if tier.user_count > 0
      {
        business: nil,
        errors: ["Cannot delete membership tiers with active members"]
      }
    else
      tier.destroy!
      {
        business: tier.business,
        errors: []
      }
    end
    
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