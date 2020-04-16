class Mutations::CreateBusiness < Mutations::BaseMutation
  requires_authentication!
  null true

  argument :name, String, required: true
  argument :address, String, required: true
  argument :phone_number, String, required: true
  argument :description, String, required: true
  argument :address, String, required: true
  argument :logo, String, required: false
  argument :tiers, [String], required: true

  field :business, Types::BusinessType, null: true
  field :errors, [String], null: false

  def resolve(name: nil, logo: nil, description: nil, phone_number: nil, address: nil, tiers: nil)
    business = Business.create(
      name: name,
      address: address,
      phone_number: phone_number,
      description: description,
    )

    if logo.present?
      business.avatar.attach(data: logo)
    end

    if business.save
      tiers.each do |tier|
        business.tiers.create(
          name: tier
        )
      end

      unless context[:current_user].nil?
        InviteCode.create(
          code: "INITIAL",
          admin_id: context[:current_user].id,
          business_id: business.id,
        )
      end
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