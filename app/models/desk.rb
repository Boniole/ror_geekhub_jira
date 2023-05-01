# == Schema Information
#
# Table name: desks
#
#  id            :bigint           not null, primary key
#  columns_count :integer          default(0), not null
#  deleted_at    :datetime
#  name          :string           default("Your Desk")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  project_id    :bigint           not null
#
# Indexes
#
#  index_desks_on_deleted_at  (deleted_at)
#  index_desks_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#
class Desk < ApplicationRecord
  include Deskable

  belongs_to :project
  has_many :columns, dependent: :destroy

  acts_as_paranoid

  after_create :create_columns

  after_restore :restore_columns
end
