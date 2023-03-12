class Column < ApplicationRecord
  belongs_to :columnntable, polymorphic: true

  validates :name, presence: true, length: { in: 3..14 }
end
