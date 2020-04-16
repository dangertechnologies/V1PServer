module Types
  class BusinessType < Types::BaseObject
    field :id, Integer, null: false
    field :name, String, null: true
    field :address, String, null: true
    field :phone_number, String, null: true
    field :description, String, null: true
    field :is_enabled, Boolean, null: true
    field :is_subscribed, Boolean, null: true
    field :last_payment_at, Integer, null: true
    field :logo, String, null: true

    field :tiers, [Types::TierType], null: false
    field :users, Types::UserType.connection_type, null: false

    def logo
      return nil unless object.logo.present?
      Rails.application.routes.url_helpers
           .rails_blob_path(
             object.logo,
             only_path: true
      )
    end

    def users
      User.joins(:tier).where(tiers: { business: object })
    end
  end
end
