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
class Desk < ApplicationRecord
  belongs_to :project
  has_many :columns, as: :columnable, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3 }

  after_create :create_columns

  private

  def create_columns
    ['ToDo', 'In progress', 'In review', 'Done'].each {|name| columns.create(name: name) }
  end
end
