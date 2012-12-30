class User < ActiveRecord::Base
  devise(:database_authenticatable,
         :recoverable,
         :confirmable,
         # :registerable, # TODO: figure out email on heroku
         :rememberable,
         :trackable,
         :validatable)

  attr_accessible :email, :password, :password_confirmation, :remember_me
end
