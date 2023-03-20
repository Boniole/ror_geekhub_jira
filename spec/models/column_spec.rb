# == Schema Information
#
# Table name: columns
#
#  id              :bigint           not null, primary key
#  columnable_type :string           not null
#  name            :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  columnable_id   :bigint           not null
#  desk_id         :bigint           not null
#
# Indexes
#
#  index_columns_on_columnable  (columnable_type,columnable_id)
#  index_columns_on_desk_id     (desk_id)
#
# Foreign Keys
#
#  fk_rails_...  (desk_id => desks.id)
#
require 'rails_helper'

RSpec.describe Column, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
