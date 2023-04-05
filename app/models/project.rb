# == Schema Information
#
# Table name: projects
#
#  id         :bigint           not null, primary key
#  name       :string
#  status     :integer          default("open")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
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
  belongs_to :user
  has_many :desks, dependent: :destroy
  has_many :documents, dependent: :destroy
  has_many :memberships
  has_many :users, through: :memberships

  validates :name, presence: true, length: { minimum: 3 }
  validates :status, presence: true

  after_create :create_desk

  enum :status, %i[open close], default: :open

  private

  def create_desk
    desks.create
  end
end
