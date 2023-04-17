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
  include Validatable::Name

  belongs_to :project
  has_many :columns, dependent: :destroy # https://github.com/rubysherpas/paranoia

  after_create :create_columns

  private

  def create_columns
    # string to constant
    ['ToDo', 'In progress', 'In review', 'Done'].each.with_index do |name, index|
      columns.create(name:, ordinal_number: index + 1)
    end
  end
end
