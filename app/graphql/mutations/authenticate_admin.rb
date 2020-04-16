class Mutations::AuthenticateAdmin < Mutations::BaseMutation
  argument :provider, Types::OauthProviderType, required: true
  argument :token, String, required: true
  argument :invite_code, String, required: false
  

  field :admin, Types::AdminType, null: true
  field :errors, [String], null: false

  def resolve(provider: nil, token: nil, invite_code: nil)
    case provider.to_sym
    when :google
      identity = ::Identity.from_google(token: token)
    when :demo
      raise ActiveRecord::RecordNotFound.new unless ::Identity.where(provider: :DEMO).pluck(:token).to_a.include?(token)
      identity = ::Identity.find_by(token: token)
    end

    if invite_code.present?
      identity
    end

    {
      admin: identity.admin,
      errors: []
    }

  rescue ActiveRecord::RecordInvalid => invalid
    # Failed save, return the errors to the client
    {
      admin: nil,
      errors: invalid.record.errors.full_messages
    }
  rescue ActiveRecord::RecordNotSaved => error
    # Failed save, return the errors to the client
    {
      admin: nil,
      errors: invalid.record.errors.full_messages
    }
  rescue ActiveRecord::RecordNotFound => error
    {
      admin: nil,
      errors: [ error.message ]
    }
  end

  private
  def auth_token
    if entity.respond_to? :to_token_payload
      AuthToken.new payload: entity.to_token_payload
    else
      AuthToken.new payload: { sub: entity.id }
    end
  end
end
