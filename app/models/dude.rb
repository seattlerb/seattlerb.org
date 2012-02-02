class Dude < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :ruby_gems_id
  has_many :affiliations, :dependent => :destroy
  has_many :projects, :through => :affiliations
end
