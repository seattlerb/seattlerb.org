# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

desc "test with coverage"
task "test:cov" do
  ENV["COV"] = "1"
  Rake::Task[:test].invoke
end
