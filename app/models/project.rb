# == Schema Information
#
# Table name: projects
#
#  id          :bigint           not null, primary key
#  deleted_at  :datetime
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
#  index_projects_on_deleted_at  (deleted_at)
#  index_projects_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Project < ApplicationRecord
  include Projectable

  belongs_to :user
  has_many :memberships
  has_many :users, through: :memberships
  has_many :desks, dependent: :destroy
  has_many :tasks
  has_many :documents, as: :documentable

  acts_as_paranoid

  enum :status, %i[open close], default: :open

  after_create :create_desk

  after_restore :restore_desks
end
