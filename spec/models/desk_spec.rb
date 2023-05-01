# == Schema Information
#
# Table name: desks
#
#  id            :bigint           not null, primary key
#  columns_count :integer          default(0), not null
#  deleted_at    :datetime
#  name          :string           default("Your Desk")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  project_id    :bigint           not null
#
# Indexes
#
#  index_desks_on_deleted_at  (deleted_at)
#  index_desks_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#
require 'rails_helper'

RSpec.describe Desk, type: :model do
  it { should have_many :columns }
  it { should belong_to :project }

  it { should validate_presence_of :name }

  it 'must have 4 colums for new desk' do
    user = User.new(first_name: 'John',
                    last_name: 'Travolta',
                    email: Random.hex(5)+'@gmail.com',
                    password: 'Home2023Ls')
    user.save!

    project = Project.new(name: 'My project', user_id: user.id)
    project.save!

    desk = Desk.new(project_id: project.id)
    desk.save!

    expect(desk.columns.count).to be 4
  end
end
