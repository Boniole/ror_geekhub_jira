class Person
  include ActiveModel::API
  attr_accessor :name, :age

  validates :name, length: { in: 3..30 }
  
  def initialize(attributes={})
    super
    @omg ||= true
  end
end