# == Schema Information
#
# Table name: desks
#
#  id         :bigint           not null, primary key
#  name       :string
#  project_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Desk < ApplicationRecord
  belongs_to :project
  # has_many :users

  validates :name, presence: true, length: { minimum: 3 }
end
