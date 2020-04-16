class Mutations::CreateUser < Mutations::BaseMutation
  requires_authentication!
  null true

  argument :first_name, String, required: true
  argument :last_name, String, required: true
  argument :phone, String, required: true
  argument :avatar, String, required: true
  argument :card_number, String, required: true
  argument :tier_id, Integer, required: true

  field :user, Types::UserType, null: true
  field :errors, [String], null: false

  def resolve(first_name: nil, last_name: nil, phone: nil, avatar: nil, card_number: nil, tier_id: nil)
     user = User.create(
      first_name: first_name,
      last_name: last_name,
      phone: phone,
      card_number: card_number,
      tier_id: tier_id
    )

    if avatar.present?
      user.avatar.attach(data: avatar)
    end
    
    if user.save
      # Successful creation, return the created object with no errors
      {
        user: user,
        errors: [],
      }
    else
      # Failed save, return the errors to the client
      {
        user: nil,
        errors: user.errors.full_messages
      }
    end
  end
end