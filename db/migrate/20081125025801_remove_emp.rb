class RemoveEmp < ActiveRecord::Migration
  def self.up
    emp  = Project.find_by_name("emp")
    evan = Dude.find_by_name("Evan Phoenix")
    
    Affiliation.find_by_project_id_and_dude_id(emp, evan)
    emp.destroy
  end

  def self.down
    puts "destruction!"
  end
end
