class ReviewUserJob < ApplicationJob
  queue_as :default

  def perform user
    user.reviews.where(field: [:website, :rubygems, :github]).destroy_all

    check_url user, :website,  user.website       if user.website.present?
    check_url user, :rubygems, rubygems_url(user) if user.rubygems_name.present?
    check_url user, :github,   github_url(user)   if user.github_name.present?
    # TODO: email_address?
    user
  end

  def rubygems_url(u) = "https://rubygems.org/api/v1/profiles/#{u.rubygems_name}"
  def github_url(u)   = "https://api.github.com/users/#{u.github_name}"
end
