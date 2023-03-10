# == Schema Information
#
# Table name: projects
#
#  id         :bigint           not null, primary key
#  name       :string
#  status     :integer          default("closed")
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Project < ApplicationRecord
  belongs_to :user
  has_many :desks, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3 }
  validates :status, presence: true


  enum status: [ :closed, :open ]
end
