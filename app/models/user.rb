class User < ApplicationRecord
  has_secure_password

  has_many :sessions,     dependent: :destroy
  has_many :affiliations, dependent: :destroy
  has_many :projects,     through:   :affiliations
  has_many :reviews,      dependent: :destroy, as: :referrable

  scope :orphans, -> { where.missing(:projects).where.not(verified: true) }

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  scope :verified, -> { where verified:true }

  def admin? = admin

  def rubygems_url = "https://rubygems.org/profiles/#{rubygems_name}"
  def github_url   = "https://github.com/#{github_name}"
end
