#!/usr/bin/env rake
# encoding: utf-8
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

SeattlerbOrg::Application.load_tasks

$-w = false # asshat, don't mess with my warn.

task :update_gems => :environment do
  require "open-uri"
  require "json"

  users = {}

  Dude.find(:all).map(&:ruby_gems_id).sort.each do |user|
    warn "Fetching #{user}"
    json = URI.parse("http://rubygems.org/api/v1/owners/#{user}/gems.json").read
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
  known_users    = Hash[Dude.all.map { |u| [u.ruby_gems_id, u] }]

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
      proj.dudes << known_users[user]
    end
  end
end
