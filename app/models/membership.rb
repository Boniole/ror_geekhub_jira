# == Schema Information
#
# Table name: memberships
#
#  id         :bigint           not null, primary key
#  role       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  project_id :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_memberships_on_project_id  (project_id)
#  index_memberships_on_user_id     (user_id)
#
class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :project

  enum :role, %i[member admin], default: :member

  scope :get_project, ->(id) { where(project_id: id) }
end
