module Types
  class InviteCodeType < Types::BaseObject
    field :id, Integer, null: false
    field :code, String, null: false
  end
end
