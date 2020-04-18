class Mutations::UpdateTier < Mutations::BaseMutation
  requires_authentication!
  null true

  argument :tier_id, Integer, required: true
  argument :name, String, required: true

  field :business, Types::BusinessType, null: true
  field :errors, [String], null: false

  def resolve(tier_id: nil, name: string)
    tier = Tier.where(
      business: context[:current_user].businesses
    ).where(tier_id: tier_id)

    tier.assign_attributes(
      name: name,
    )

    tier.save!

    # Successful creation, return the created object with no errors
    {
      business: tier.business,
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