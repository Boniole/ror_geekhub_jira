# == Schema Information
#
# Table name: desks
#
#  id            :bigint           not null, primary key
#  columns_count :integer          default(0), not null
#  name          :string           default("Your Desk")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  project_id    :bigint           not null
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
  include Validatable::Deskable

  belongs_to :project
  has_many :columns, dependent: :destroy # TODO https://github.com/rubysherpas/paranoia

  after_create :create_columns

  private

  def create_columns
    RANGE_COLUMN_NAMES.each { |name| columns.create(name: name) }
  end
end
