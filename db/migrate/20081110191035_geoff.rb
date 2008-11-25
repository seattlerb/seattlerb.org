class Geoff < ActiveRecord::Migration
  PROJECTS = [
    ["Bong", "http://rubyforge.org/projects/bong", "Bong helps you hit your website. Uses httperf and a config file to run a suite of benchmarks against a set of URLs. Multi-run comparisons and graphical output are also planned. Works with any web technology, framework, or language."],
    ["Gruff", "http://rubyforge.org/projects/gruff", "Gruff is a beautiful graphing library for Ruby using RMagick. Plot multiple datasets in color or implement your own colorful theme. Homepage at http://nubyonrails.com/pages/gruff, Git source at http://github.com/topfunky/gruff/tree/master"],
    ["sparklines", "http://rubyforge.org/projects/sparklines", "Library for generating small graphs to be used inline, in tables, or magnified. Can be used alone or with Rails. Source available via Git at http://github.com/topfunky/sparklines/tree/master"],
    ["sparklines_generator", "http://rubyforge.org/projects/sparklines", "Library for generating small graphs to be used inline, in tables, or magnified. Can be used alone or with Rails. Source available via Git at http://github.com/topfunky/sparklines/tree/master"],
    ["RaPT (Rails Plugin Tool)", "http://rubyforge.org/projects/rapt", "RaPT (Rails Plugin Tool) is a faster, updated replacement for the ./script/plugin tool that ships with Ruby on Rails."],
    ["autotask", "http://rubyforge.org/projects/autotask", "A command line tool for running any shell command when watched Ruby files change. Useful for test driven development or running rake tasks when files are saved or updated. MacOSX-dependent for the first release."],
    ["testcamp", "http://rubyforge.org/projects/testcamp", "A testing library for Camping in the style of Test::Unit, based upon Mosquito."],
    ["Mosquito", "http://rubyforge.org/projects/mosquito", "Mosquito is a simple test framework for why the lucky stiff's Camping web library. It provides simple hooks and a few assertions for doing unit and functional tests on your Camping models and controllers."],
    ["google-checkout", "http://rubyforge.org/projects/google-checkout", "A library to generate calls to the Google Checkout API."],
    ["ruby-hmac", "http://rubyforge.org/projects/ruby-hmac", "An implementation of the HMAC message authentication code."]
  ]

  def self.up
    geoff = Dude.create!(:name => "Geoffrey Grosenbach", :website => "http://nubyonrails.com")

    PROJECTS.each do |project|
      project = Project.create!(:name => project.first, :url => project.last, :description => project[1])
      Affiliation.create!(:dude => geoff, :project => project)
    end
  end

  def self.down
    Dude.find_by_name("Geoffrey Grosenbach").destroy

    PROJECTS.each do |project|
      Project.find_by_name(project.first).destroy
      Affiliation.find_all_by_dude_id(Dude.find_by_name("Geoffrey Grosenbach"))
    end
  end
end
