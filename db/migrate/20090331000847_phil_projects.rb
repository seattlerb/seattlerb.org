class PhilProjects < ActiveRecord::Migration
  PROJECTS = [{:name => 'harker', :url => 'http://github.com/technomancy/harker',
                :description => 'Rails deployments via RubyGems--because a package manager is a terrible thing to waste.'},
              {:name => 'dnssd', :url => 'http://rubyforge.org/projects/dnssd',
                :description => 'A Ruby binding to the DNS Service Discovery API.'},
              { :name => 'bludgeon', :url => 'http://github.com/technomancy/bludgeon',
                :description => 'A tool which will tell you if a given library is so large that you could bludgeon someone to death with a printout of it.' }]
  # add harker, gitjour, dnssd, and bludgeon
  # remove clip dupe; describe watcher
  def self.up
    phil = Dude.find_by_name("Phil Hagelberg")

    PROJECTS.each do |attribs|
      p = Project.create!(attribs)
      Affiliation.create!(:dude => phil, :project => p)
    end

    watcher = Project.find_by_name('Watcher in the Water')
    watcher.update_attribute(:description,
                             'Want to know when the page at a URL changes? The Watcher in the Water will tell you over Jabber.')

    gitjour = Project.find_by_name('gitjour')
    gitjour.update_attribute(:url, 'http://github.com/technomancy/gitjour')
    Affiliation.create!(:dude => phil, :project => gitjour)

    # In production there are two clips to my name, but I can't repro in dev.
    clips = Project.find_by_name('clip').affiliations.select{ |a| a.dude == phil }
    clips[1].destroy if clips[1]
  end

  def self.down
    PROJECTS.keys.each { |p| Project.find_by_name(p[:name]).destroy }
  end
end
