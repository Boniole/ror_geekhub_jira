# == Schema Information
#
# Table name: columns
#
#  id                :bigint           not null, primary key
#  columnntable_type :string           not null
#  name              :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  columnntable_id   :bigint           not null
#
# Indexes
#
#  index_columns_on_columnntable  (columnntable_type,columnntable_id)
#
require 'rails_helper'

RSpec.describe Column, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
