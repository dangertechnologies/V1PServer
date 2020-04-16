class Mutations::DeleteBusiness < Mutations::BaseMutation
  requires_authentication!
  null true

  argument :id, Integer, required: true

  field :business, Types::BusinessType, null: true
  field :errors, [String], null: false

  def resolve(id: nil)
    business = Business.find(id)
    
    if busines.destroy
      # Successful creation, return the created object with no errors
      {
        business: business,
        errors: [],
      }
    else
      # Failed save, return the errors to the client
      {
        business: nil,
        errors: business.errors.full_messages
      }
    end
  end
end