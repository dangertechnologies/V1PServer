# == Schema Information
#
# Table name: visits
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  admin_id   :integer
#
class Visit < ApplicationRecord
  belongs_to :user
  counter_culture :user, column_name: "visit_count"
end
