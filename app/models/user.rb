class User < ApplicationRecord
  has_secure_password

  has_many :sessions,     dependent: :destroy
  has_many :affiliations, dependent: :destroy
  has_many :projects,     through:   :affiliations

  scope :orphans, -> { where.missing(:projects).where.not(verified: true) }

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
