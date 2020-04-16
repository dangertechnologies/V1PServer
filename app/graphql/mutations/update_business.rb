class Mutations::UpdateBusiness < Mutations::BaseMutation
  requires_authentication!
  null true

  argument :id, Integer, required: true
  argument :name, String, required: false
  argument :address, String, required: false
  argument :phone_number, String, required: false
  argument :description, String, required: false

  field :business, Types::BusinessType, null: true
  field :errors, [String], null: false

  def resolve(id: nil, name: nil, logo: nil, description: nil, address: nil)
    business = Business.find(id).assign_attributes(
      {
        name: name,
        address: address,
        phone_number: phone_number,
        description: description,
      }.reject { |(_, v)| v.nil? }
    )
    
    if logo.present?
      business.logo.attach(data: logo)
    end

    if busines.save
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