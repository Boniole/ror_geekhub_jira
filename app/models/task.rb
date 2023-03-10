# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  title       :text
#  description :string
#  priority    :integer
#  status      :integer
#  label       :text
#  estimate    :datetime
#  start       :date
#  end         :date
#  assignee_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Task < ApplicationRecord
  # belongs_to :project
  # belongs_to :desk
  # belongs_to :user
  has_many :comments, dependent: :destroy
end
