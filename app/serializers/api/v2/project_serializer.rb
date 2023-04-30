# == Schema Information
#
# Table name: projects
#
#  id          :bigint           not null, primary key
#  git_repo    :string
#  git_url     :string
#  name        :string
#  status      :integer
#  tasks_count :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_projects_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Api::V2::ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :status, :git_url, :git_repo, :updated_at

  has_many :desks, serializer: Api::V2::DeskSerializer
  has_many :memberships, serializer: Api::V1::MembershipSerializer
end
