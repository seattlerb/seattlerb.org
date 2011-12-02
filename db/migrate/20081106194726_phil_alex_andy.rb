# -*- coding: utf-8 -*-
class PhilAlexAndy < ActiveRecord::Migration
  def self.up
    ["Alex Vollmer", "Andy Smith"].each do |dude|
      Dude.create!(:name => dude)
    end

    [
      ["feed-normalizer", "http://rubyforge.org/projects/feed-normalizer/", %q(An extensible wrapper for Atom and RSS parsers.)],
      ["ofx-parser", "http://rubyforge.org/projects/ofx-parser/", %q(ofx-parser is a ruby library for parsing OFX 1.x data.)],
      ["word_salad", "http://github.com/alexvollmer/word_salad", %q(Generate strings of random English text)],
      ["chikken_in_a_bukket", "http://github.com/alexvollmer/chikken_in_a_bukket", %q(Easy access to S3 through your web browser.)],
      ["clip", "http://github.com/alexvollmer/clip", %q(Yeah yeah yeah. Why in heaven's name do we need yet another command-line parser? Well, OptionParser is all well and good[1], but doesn't grease the skids as much as I'd like. Simple things should be dead simple (1 LOC), and more flexibility is there if you need it.)],
      ["Watcher in the Water", "", %q()],
      ["Roast Beef", "http://roastbeef.rubyforge.org/", %q(uh ok so roast beef is some kind of package manager that is for bleeding-edge programs. so basically it does not have its own repositories. instead it just will download source from the upstream repository and will do all the necessary steps to install . you get things that are as fresh as possible. i am talking about really fresh like your eggs and milk. roast beef saves you from having to look up the repository locations for all the stuff you want to build from source. it also abstracts away the differences in build processes. say you want the latest version of such a package as gnu emacs. so you grab the source but you know emacs is a little different from other packages and requires "make bootstrap" in between the configure and make step. with roastbeef all the complexity of such things is hidden from you. and if you have a lot of stuff built from source you can keep them all up to date with a single command.)],
      ["rinari", "http://rinari.rubyforge.org/", %q(Rinari Is Not A Rails IDE -- Well, ok it kind of is. Rinari is an Emacs minor mode that is aimed towards making Emacs into a top-notch Ruby and Rails development environment.)],
      ["RPlanet", "http://rubyforge.org/projects/rplanet/", %q(rPlanet is a reimplementation of the Python RSS aggregator called Planet.)],
      ["RAV", "http://rav.rubyforge.org/", %q(Deprecation Warning. Unfortunately RAV hasn't been updated since the days of Rails 1.1. If you're looking for a way to visualize your Rails apps, you would do well to investigate Railroad, a more up-to-date project with similar goals.)],
      ["Conspire", "http://rubyforge.org/projects/conspire/", %q(Conspire is a real-time collaborative editing platform using Git as a transport layer.)],
      ["Augment", "http://augment.rubyforge.org/", %q(Augment is a system for gathering metadata from code and displaying it. This metadata will include test failures, test coverage levels, complexity metrics, and others. The display frontends are pluggable so as to interface with many editors and environments.)],
      ["Bus Scheme", "http://bus-scheme.rubyforge.org/", %q(Bus Scheme is a Scheme written in Ruby, but implemented on the bus! Every programmer must implement Scheme as a rite of passage; this is mine. Note that at least half of the implementation of Bus Scheme must be written while on a bus. Documentation, tests, and administrivia may be accomplished elsewhere, but the majority of actual implementation code is strictly bus-driven. Patches are welcome especially if they were written while riding a bus. (If your daily commute does not involve a bus but you want to submit a patch, we may be able to work something out regarding code written on trains, ferries, or perhaps even carpool lanes.) Bus Scheme is primarily a toy; using it for anything serious is (right now) ill-advised. Bus Scheme aims for general Scheme usefulness optimized for learning and fun. It‘s not targeting R5RS or anything like that.)]
    ].each do |p|
      project             = Project.new(:name => p.first)
      project.url         = p[1]
      project.description = p.last if p.last
      project.save!
    end

    [
      ["Alex Vollmer", "chikken_in_a_bukket"],
      ["Alex Vollmer", "clip"],
      ["Alex Vollmer", "word_salad"],
      ["Andy Smith", "ofx-parser"],
      ["Andy Smith", "feed-normalizer"],
      ["Phil Hagelberg", "Augment"],
      ["Phil Hagelberg", "Bus Scheme"],
      ["Phil Hagelberg", "Conspire"],
      ["Phil Hagelberg", "RAV"],
      ["Phil Hagelberg", "rinari"],
      ["Phil Hagelberg", "Roast Beef"],
      ["Phil Hagelberg", "RPlanet"],
      ["Phil Hagelberg", "Watcher in the Water"]
    ].each do |a|
      dude    = Dude.find_by_name(a.first)
      project = Project.find_by_name(a.last)
      Affiliation.create!(:dude => dude, :project => project)
    end


  end

  def self.down
    ["Alex Vollmer", "Andy Smith"].each do |dude|
      Dude.find_by_name(dude).destroy
    end
    
    ["feed-normalizer", "ofx-parser", "word_salad", "chikken_in_a_bukket", "clip",
      "Watcher in the Water", "Roast Beef", "rinari", "RPlanet", "RAV", "Conspire",
      "Augment", "Bus Scheme"].each do |project|
      Project.find_by_name(project).destroy
    end

    [
      ["Alex Vollmer", "chikken_in_a_bukket"],
      ["Alex Vollmer", "clip"],
      ["Alex Vollmer", "word_salad"],
      ["Andy Smith", "ofx-parser"],
      ["Andy Smith", "feed-normalizer"],
      ["Phil Hagelberg", "Augment"],
      ["Phil Hagelberg", "Bus Scheme"],
      ["Phil Hagelberg", "Conspire"],
      ["Phil Hagelberg", "RAV"],
      ["Phil Hagelberg", "rinari"],
      ["Phil Hagelberg", "Roast Beef"],
      ["Phil Hagelberg", "RPlanet"],
      ["Phil Hagelberg", "Watcher in the Water"]
    ].each do |a|
      Affiliation.find_by_dude_id_and_project_id(Dude.find_by_name(a.first), Project.find_by_name(a.last))
    end
  end
end
