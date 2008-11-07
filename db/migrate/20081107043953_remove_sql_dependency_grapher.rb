class RemoveSqlDependencyGrapher < ActiveRecord::Migration
  def self.up
    Affiliation.find_all_by_project_id(
      Project.find_by_name("SQLDependencyGrapher")
    ).each {|a| a.destroy}

    Project.find_by_name("SQLDependencyGrapher").destroy

    Project.find_by_name("sql_dep_graph").update_attributes(
      :url => "http://rubyforge.org/projects/rails-analyzer/",
      :description => "Reads the Rails log files and exposes potential points of optimization."
    )
  end

  def self.down
    raise IrreversibleMigration
  end
end
