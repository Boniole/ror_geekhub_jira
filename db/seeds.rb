# frozen_string_literal: true

require 'ffaker'
require_relative 'constants_file'

20.times do
  user = User.new(first_name: NAME.sample, last_name: FFaker::Name.last_name,
                  email: FFaker::Internet.free_email)
  user.password = 'Password123'
  user.password_confirmation = 'Password123'
  user.save!
end

10.times do |i|
  user = User.find(i + 1)
  project = user.projects.create(name: "project ##{i}")

  # add memberships
  project.memberships.create(user_id: user.id, role: 'admin')

  10.times do |e|
    if i < 10
      project.memberships.create!(user_id: User.find(i + e + 2).id, role: 'member')
    else
      project.memberships.create!(user_id: User.find(i - e + 1).id, role: 'member')
    end
  end

  # find Desk
  desk = Desk.find_by(project_id: project.id)

  # create Tasks
  25.times do
    description = [FRONT, QA, BACK].sample

    column = Column.where(desk_id: desk.id).sample
    task = column.tasks.create(
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
      Comment.create(
        body: COMMENT.sample,
        user_id: project.memberships.sample.id,
        commentable_type: 'Task',
        commentable_id: task.id
      )
    end
  end
end
