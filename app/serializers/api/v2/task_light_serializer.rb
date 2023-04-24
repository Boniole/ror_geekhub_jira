class Api::V1::TaskLightSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :assignee, :name, :description, :tag_name, :priority_number,
             :priority, :status, :created_at, :updated_at, :comments_count

  def comments_count
    object.comments.count
  end
end
