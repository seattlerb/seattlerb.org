class CleanUpBadData < ActiveRecord::Migration
  def self.up
    %w(ActsAsEscaped ActsAsFastNestedSet AddressBookImporter AdoccaMemcache app-ctx babel
    backlog CachedSupermodel captools charnames chirp chronic creator crosstab drawr esrl
    GraphvizR jungle kickstart laysl Memoize metainspector namedarguments ok-extensions
    paginator picasaweb rails_creator rbml recurring RequirePaths rme2day rogue_parser rplug
    rtunnel ruby-maidcafe s3-ruby ServeWebdav static StreetAddress submerge tuxdroid
    tv-dot-com yummy test-unit-full test-unit-runner-fox test-unit-runner-gtk2
    test-unit-runner-tk).each do |project|
      Affiliation.find_by_project_id_and_dude_id(Project.find_by_name(project),
                                                     Dude.find_by_name("Ryan Davis")).destroy
    end

    %w(ActsAsEscaped ActsAsFastNestedSet AddressBookImporter).each do |project|
      Affiliation.find_all_by_project_id(Project.find_by_name(project)).each {|a| a.destroy}
      Project.find_by_name(project).destroy
    end
  end

  def self.down
    raise IrreversibleMigration
  end
end
