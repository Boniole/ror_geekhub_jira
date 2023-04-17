# == Schema Information
#
# Table name: columns
#
#  id             :bigint           not null, primary key
#  name           :text
#  ordinal_number :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  desk_id        :bigint           not null
#
# Indexes
#
#  index_columns_on_desk_id  (desk_id)
#
# Foreign Keys
#
#  fk_rails_...  (desk_id => desks.id)
#
class Api::V2::ColumnSerializer < ActiveModel::Serializer
  attributes :id, :name, :ordinal_number, :tasks

  has_many :tasks, serializer: Api::V2::TaskSerializer
end
