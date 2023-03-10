# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :string
#  task_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Comment < ApplicationRecord
  belongs_to :task
  # belongs_to :user
end
