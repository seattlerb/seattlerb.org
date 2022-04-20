class ActiveRecord::Base
  class << self
    alias habtm has_and_belongs_to_many
  end
end
