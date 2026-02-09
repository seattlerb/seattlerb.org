class Review < ApplicationRecord
  def reference = referrable
  def name = reference&.name || "unknown"

  belongs_to :referrable, polymorphic: true
end
