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
class Project < ApplicationRecord
  include Validatable::Projectable

  belongs_to :user
  has_many :desks, dependent: :destroy
  has_many :documents, as: :documentable
  has_many :memberships
  has_many :users, through: :memberships

  enum :status, %i[open close], default: :open

  after_create :create_desk

  private

  def create_desk
    desks.create
  end
end
