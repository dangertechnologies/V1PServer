class Resolvers::UserResolver < Resolvers::BaseResolver
  requires_authentication!
  type Types::UserType, null: true

  argument :card_number, String, required: false
  argument :business_id, Integer, required: true
  argument :id, String, required: false

  def resolve(card_number: nil, business_id: nil, id: nil)
    # call your application logic here:
    if card_number.present?
      Business.find(business_id).users.find_by(card_number: card_number)
    elsif id.present?
      User.find_by(id: id)
    end
  end
end