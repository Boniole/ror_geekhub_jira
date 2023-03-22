# == Schema Information
#
# Table name: desks
#
#  id         :bigint           not null, primary key
#  name       :string           default("Your Desk")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  project_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_desks_on_project_id  (project_id)
#  index_desks_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#  fk_rails_...  (user_id => users.id)
#
class Desk < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_many :columns, as: :columnable, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3 }
end
