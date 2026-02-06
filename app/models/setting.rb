class Setting < ApplicationRecord
  belongs_to :location # feels icky saying belongs_to but we own the key
end
