class RemoveOrphanProjects < ActiveRecord::Migration
  def self.up
    Project.all.each do |p|
      a = Affiliation.find_all_by_project_id(p)
      p.destroy if a.length.zero?
    end
  end

  def self.down
    raise IrreversibleMigration
  end
end
