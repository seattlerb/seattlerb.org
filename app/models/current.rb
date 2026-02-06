class Current < ActiveSupport::CurrentAttributes
  attribute :session
  delegate :user, to: :session, allow_nil: true

  def self.location
    Setting.first.location
  end

  def self.location= o
    Setting.first.update_attribute! :location, o
  end
end
