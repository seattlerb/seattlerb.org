namespace :twitter do
  desc "update twitter avatars"
  task :update_avatars do
    Rake::Task[:environment].invoke
    people = Member.verified
    people.each do |person|
      puts "Updating #{person.name}..."
      person.update_avatar!
      puts person.image_url
    end
  end
end

desc "update members and projects"
task :update_gems => :environment do
  require "open-uri"
  require "json"

  users = {}

  Member.all.map(&:ruby_gems_id).sort.each do |user|
    next if user.empty?
    warn "Fetching #{user}"
    url  = "https://rubygems.org/api/v1/owners/#{user}/gems.json"
    json = URI.parse(url).read rescue nil
    unless json then
      warn "  bad: #{url}"
      next
    end
    gems = JSON.parse json
    users[user] = gems
  end

  rubygems      = {}
  users_per_gem = Hash.new { |h,k| h[k] = [] }

  users.each do |user, gems|
    gems.each do |gem|
      rubygems[gem["name"]] ||= gem
      users_per_gem[gem["name"]] << user
    end
  end

  usernames      = users.keys.sort
  gemnames       = rubygems.keys.sort
  known_projects = Hash[Project.all.map { |p| [p.name, p] }]
  known_users    = Hash[Member.all.map { |u| [u.ruby_gems_id, u] }]

  add = (gemnames - known_projects.keys)
  del = (known_projects.keys - gemnames)

  del.each do |name|
    warn "Deleting project #{name}"
    Project.find_by_name(name).destroy
  end

  add.each do |name|
    warn "Adding project #{name}"
    proj  = rubygems[name]
    users = users_per_gem[name]

    url = proj["source_code_uri"] || proj["project_uri"] || proj["project_uri"]
    desc = proj["info"]

    newproj = Project.create :name => name, :url => url, :description => desc

    known_projects[name] = newproj
  end

  warn "Deleting all affiliations"
  Affiliation.delete_all

  users_per_gem.each do |gemname, users|
    proj = known_projects[gemname]

    warn "Project #{proj.name}"

    users.each do |user|
      warn "  Adding user #{user}"
      proj.members << known_users[user]
    end
  end
end
