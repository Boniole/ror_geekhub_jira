# == Schema Information
#
# Table name: desks
#
#  id         :bigint           not null, primary key
#  name       :string           default("Your Desk")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  project_id :bigint           not null
#
# Indexes
#
#  index_desks_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#
class Api::V1::DeskSerializer < ActiveModel::Serializer
  attributes :id, :name, :columns

  has_one :project, serializer: Api::V2::ProjectSerializer
  has_many :columns, serializer: Api::V2::ColumnSerializer
end
