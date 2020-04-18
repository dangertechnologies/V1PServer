class Mutations::CreateTier < Mutations::BaseMutation
  requires_authentication!
  null true

  argument :business_id, Integer, required: true
  argument :name, String, required: true

  field :business, Types::BusinessType, null: true
  field :errors, [String], null: false

  def resolve(business_id: nil, name: string)
    business = Business.find(business_id)

    business.tiers.create!(
      name: name
    )

    business.reload

    # Successful creation, return the created object with no errors
    {
      business: business,
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