module Validatable 
  extend ActiveSupport::Concern

  NAME_RANGE_LENGTH = 3..30
  DESCRIPTION_RANGE_LENGTH = 3..2500

  module Name
    extend ActiveSupport::Concern
    include Validatable

    included do
      validates :name, presence: true, length: { in: NAME_RANGE_LENGTH }
    end
  end

  module Description
    extend ActiveSupport::Concern
    include Validatable

    included do
      validates :description, length: { in: DESCRIPTION_RANGE_LENGTH }
    end
  end

  module Body
    extend ActiveSupport::Concern
    include Validatable

    included do
      validates :body, length: { in: DESCRIPTION_RANGE_LENGTH }
    end
  end
end
