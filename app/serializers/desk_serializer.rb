# == Schema Information
#
# Table name: desks
#
#  id         :bigint           not null, primary key
#  name       :string
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
class DeskSerializer < ActiveModel::Serializer
  attributes :name

  has_one :project, serializer: ProjectSerializer
  has_many :columns, serializer: ColumnSerializer
end
