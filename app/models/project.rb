class Project < ApplicationRecord
  has_many :affiliations, dependent: :destroy
  has_many :users, through: :affiliations

  scope :orphans, -> { where.missing :users }

  def rubygems_url = "https://rubygems.org/gems/#{name}"
end
