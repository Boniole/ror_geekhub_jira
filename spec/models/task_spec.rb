# == Schema Information
#
# Table name: tasks
#
#  id              :bigint           not null, primary key
#  deleted_at      :datetime
#  description     :string
#  end_date        :date
#  estimate        :text
#  label           :text
#  name            :text
#  priority        :integer
#  priority_number :integer
#  start_date      :date
#  status          :integer
#  tag_name        :text
#  time_work       :string
#  type_of         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  assignee_id     :integer
#  column_id       :bigint           not null
#  desk_id         :bigint           not null
#  project_id      :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_tasks_on_column_id   (column_id)
#  index_tasks_on_deleted_at  (deleted_at)
#  index_tasks_on_desk_id     (desk_id)
#  index_tasks_on_project_id  (project_id)
#  index_tasks_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (column_id => columns.id)
#  fk_rails_...  (desk_id => desks.id)
#  fk_rails_...  (project_id => projects.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RANGE_PASSWORD_LENGTH = 8..20

RSpec.describe User, type: :model do

  it { should have_many :memberships }
  it { should have_many :projects }
  it { should have_many :tasks }
  it { should have_many :comments }
  it { should have_many :documents }

  it { should validate_uniqueness_of(:email) }
  it { should have_secure_password }

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  # it { should validate_exclusion_of(:password_digest).in_range(RANGE_PASSWORD_LENGTH) }
end
