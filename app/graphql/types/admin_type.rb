module Types
  class AdminType < Types::BaseObject
    description <<-DESC
    Always contains a new authenticationToken
    the user may use to authenticate.

    TODO: Cache this token, instead of generating a new one on every request.
    DESC
    field :id, Integer, null: false
    field :authentication_token, String, null: false
    field :name, String, null: false
    field :phone, String, null: false
    field :is_assigned_to_business, Boolean, null: false
    field :businesses, [Types::BusinessType], null: true

    def authentication_token
      Knock::AuthToken.new(payload: { sub: object.id }).token
    end

    def is_assigned_to_business
      !object.invite_codes.empty?
    end
  end
end
