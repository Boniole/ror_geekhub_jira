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
require 'rails_helper'

RSpec.describe Project, type: :model do
  it { should have_many :desks }
  it { should have_many :documents }
  it { should have_many :memberships }
  it { should have_many :users }

  it { should belong_to :user }

  it { should validate_presence_of :name }

  context 'create projects' do
    user_1 = :user

    it 'must count tasks' do
      # expect(User.all.count).to be 1

      # project = Project.new(name: 'My project', user_id: user.id)
      # project.save!
      #
      # desk = Desk.new(project_id: project.id)
      # desk.save!
      #
      # column = desk.columns.last
      #
      # task = Task.new(name: 'My task',
      #                 description: 'body',
      #                 project_id: project.id,
      #                 desk_id: desk.id,
      #                 column_id: column.id,
      #                 user_id: user.id,
      #                 start_date: '2023-12-12',
      #                 end_date: '2023-12-12')
      # task.save!
      # expect(project.tasks.count).to be 1
    end
  end
end
