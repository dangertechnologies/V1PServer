module Types
  class UserType < Types::BaseObject
    field :id, Integer, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
    field :phone, String, null: false
    field :avatar, String, null: true
    field :card_number, String, null: false
    field :tier, Types::TierType, null: false
    field :is_enabled, Boolean, null: false
    field :business, Types::BusinessType, null: false
    field :visits, String, null: false
    field :visit_count, Integer, null: false
    field :last_visit, Integer, null: true
    field :created_at, Integer, null: false
    field :updated_at, Integer, null: false

    def is_enabled
      object.is_enabled == true
    end

    def last_visit 
      object.visits.count > 1 ? object.visits.last.created_at.to_i : nil
    end

    def avatar
      return nil unless object.avatar.attached?
      Rails.application.routes.url_helpers
           .rails_blob_path(
             object.avatar,
             only_path: true
      )
    end
  end
end
