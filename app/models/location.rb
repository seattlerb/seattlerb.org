class Location < ApplicationRecord
  def current?
    Setting.first.location_id == id
  end
end
