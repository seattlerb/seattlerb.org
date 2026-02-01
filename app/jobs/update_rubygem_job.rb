class UpdateRubygemJob < ApplicationJob
  def self.queue_all(ps=Project.all) = super ps.map { |p| UpdateRubygemJob.new p }

  def perform gem, info=nil
    Rails.logger.info "Updating project #%d %s" % [gem.id || -1, gem.name]

    url  = rubygems_url gem
    info ||= JSON.parse URI.parse(url).read
    key  = %w[ homepage_uri project_uri source_code_uri ].find { |key|
      url = info[key]
      next unless url.present?
      msg = "Trying url for project %s: %s" % [gem.name, url]
      try_url url, msg rescue nil
    }

    url = key && info[key]

    gem.url = url
    gem.description = info["info"]

    if gem.changed? then
      Rails.logger.info "Updating gem %s: %p" % [gem.name, gem.changes]

      gem.save!
    end

    gem
  rescue => e
    Review.create!(klass: gem.class.name,
                   ref_id: gem.id,
                   field: :rubygem_info,
                   url: url,
                   message: e.message)
  end

  def rubygems_url(gem) = "https://rubygems.org/api/v1/gems/#{gem.name}.json"
end
