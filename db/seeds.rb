require 'ffaker'

# User.all.each(&:destroy)

10.times do
  user = User.new(first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name,
                  email: FFaker::Internet.free_email)
  user.password = 'Password123'
  user.password_confirmation = 'Password123'
  user.save
end

10.times do
  user = User.all.sample
  project = Project.create(
    name: "project ##{Project.count == 0 ? 1 : Project.pluck(:id).last + 1}",
    user_id: user.id
  )

  # add memberships
  project.memberships.create(user_id: user.id, role: 'admin')

  # create Desk
  desk = Desk.find_by(project_id: project.id)

  # create Tasks
  25.times do
    column = Column.where(desk_id: desk.id).sample
    task = column.tasks.create(
      name: "Task for project number #{project.id}",
      description: "columns is #{column.name}",
      label: 'need to add label',
      estimate: '2w',
      start_date: Date.today,
      end_date: Date.today + 1,
      assignee_id: nil,
      user_id: project.user_id,
      project_id: project.id,
      desk_id: desk.id
    )

    # create Comments
    Comment.create(
      body: 'It is a body for comment',
      user_id: user.id,
      commentable_type: 'Task',
      commentable_id: task.id
    )
  end
end
