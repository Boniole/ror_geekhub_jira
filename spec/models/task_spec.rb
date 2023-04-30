# == Schema Information
#
# Table name: tasks
#
#  id              :bigint           not null, primary key
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

RSpec.describe Task, type: :model do
  # it { should belong_to :project }
  # it { should belong_to :desk }
  # it { should belong_to :column }
  # it { should belong_to :user }
  # it { should belong_to :assignee }
  it { should have_many :comments }
  it { should have_many :documents }

  it { should define_enum_for(:priority).with_values([:lowest, :low, :high, :highest]) }
  it { should define_enum_for(:type_of).with_values([:task, :bug, :epic]) }
  it { should define_enum_for(:status).with_values([:open, :close]) }

  # it { should validate_length_of(:name).is_at_least(RANGE_PASSWORD_LENGTH).on(:create) }


end
