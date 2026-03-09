class UpdateUserProjectsJob < ApplicationJob
  def self.queue_all(ps=User.all) = super ps.map { |p| new p }

  def perform user
    # gem api /api/v1/owners/zenspider/gems.json -j .

    return unless user.rubygems_name.present?

    old_gems = user.projects.index_by(&:name)
    new_gems = current_gems user

    gems = new_gems # TODO: remove

    new = gems.keys.sort
    old = old_gems.keys.sort

    # 1. add missing gems ... maybe create blank and fire off UpdateRubygemJob?
    # 2. detach gems no longer associated with
    # 3. ensure association w/ user is correct

    update = old&new
    delete = old-new
    create = new-old

    update.each do |name|
      UpdateRubygemJob.set(wait: 5).perform_later old_gems[name], new_gems[name]
    end

    Rails.logger.info "Removing from user %s projects: %p" % [user.name, delete]
    user.projects.delete delete.map { |name| old_gems[name] }

    built = create.map { |name|
      Rails.logger.info "Building %s project %s" % [user.name, name]
      project = Project.find_or_initialize_by name: name do |p|
        p.description = new_gems[name]["info"]
        p.url         = "fakeuri" # new_gems[name]["project_uri"]
      end
      user.projects << project
      project
    }

    user.save!

    jobs = built.map { |g| UpdateRubygemJob.new(g, new_gems[g.name]).set(wait: 5) }

    ApplicationJob.queue_all jobs

    [create, update, delete]
  end

  def current_gems user
    url  = URI.parse rubygems_user_url user.rubygems_name
    gems = JSON.parse url.read

    gems.to_h { |gem| [gem["name"], gem] }
  rescue => e
    user.reviews.create!(field: :rubygems,
                         url: url,
                         message: e.message)
  end

  def rubygems_user_url(u) = "https://rubygems.org/api/v1/owners/#{u}/gems.json"
end
