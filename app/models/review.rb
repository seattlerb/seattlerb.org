class Review < ApplicationRecord
  def reference
    klass.constantize.find_by id: ref_id
  end

  def name
    reference&.name || "unknown"
  end
end
