module Types
  class TierType < Types::BaseObject
    field :id, Integer, null: false
    field :business, Types::BusinessType, null: false
    field :name, String, null: false
    field :color, String, null: false
    field :description, String, null: false
    field :user_count, Integer, null: false
  end
end
