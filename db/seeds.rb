# frozen_string_literal: true

require 'ffaker'
require_relative 'constants_file'

first_user = User.new(first_name: 'John', last_name: 'Dou',
            email: 'johndou@gmail.com')
first_user.password = 'Password123'
first_user.password_confirmation = 'Password123'
first_user.save!

20.times do
  user = User.new(first_name: NAME.sample, last_name: FFaker::Name.last_name,
                  email: FFaker::Internet.free_email)
  user.password = 'Password123'
  user.password_confirmation = 'Password123'
  user.save!
end

project = first_user.projects.create(name: 'project #1')

# add memberships
project.memberships.create(user_id: first_user.id, role: 'admin')

10.times do |e|
  project.memberships.create!(user_id: User.find(e + 3).id, role: 'member')
end

# find Desk
desk = project.desks.first

# create Tasks
25.times do
  description = [FRONT, QA, BACK].sample

  column = Column.where(desk_id: desk.id).sample
  task = column.tasks.create!(
    name: "Task for project number #{project.id}",
    description: description.sample,
    label: %w[FRONT QA BACK].sample,
    estimate: '2w',
    start_date: Date.today,
    end_date: Date.today + 1,
    assignee_id: User.all.sample.id,
    user_id: project.user_id,
    project_id: project.id,
    desk_id: desk.id
  )

  # create Comments
  5.times do
    task.comments.create!(body: 'COMMENT.sample', user_id: project.memberships.sample.id)
  end
end
