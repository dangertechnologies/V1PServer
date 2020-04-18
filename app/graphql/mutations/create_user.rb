class Mutations::CreateUser < Mutations::BaseMutation
  requires_authentication!
  null true

  argument :first_name, String, required: true
  argument :last_name, String, required: true
  argument :phone, String, required: true
  argument :avatar, String, required: false
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
    
    user.save!
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