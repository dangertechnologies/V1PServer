class Types::RegistrationStageType < Types::BaseEnum
  description <<-DESC
Stages of registration for an administrator
DESC
  value :complete, "Registration complete", value: :complete
  value :select_business, "Not yet selected business", value: :select_business
end