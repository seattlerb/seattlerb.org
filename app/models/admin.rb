class Admin < ActiveRecord::Base
  devise(:database_authenticatable,
         :recoverable,
         # :confirmable,  # TODO: figure out email on heroku
         # :registerable, # TODO: figure out email on heroku
         :rememberable,
         :trackable,
         :validatable)
end
