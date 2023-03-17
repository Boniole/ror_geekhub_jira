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
class Desk < ApplicationRecord
  belongs_to :project
  has_many :column, as: :columnable

  validates :name, presence: true, length: { minimum: 3 }
end
