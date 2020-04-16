class Mutations::UpdateUser < Mutations::BaseMutation
  requires_authentication!
  null true

  argument :id, Integer, required: true
  argument :first_name, String, required: false
  argument :last_name, String, required: false
  argument :phone, String, required: false
  argument :avatar, String, required: false
  argument :tier_id, Integer, required: false

  field :user, Types::UserType, null: true
  field :errors, [String], null: false

  def resolve(id: nil, first_name: nil, last_name: nil, phone: nil, avatar: nil, tier_id: nil, card_number: nil)
     user = User.find(id)
     new_attributes = {
      first_name: first_name,
      last_name: last_name,
      phone: phone,
      card_number: card_number,
      tier_id: tier_id
    }.reject { |_, v| v.nil? }

    user.assign_attributes(new_attributes)
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