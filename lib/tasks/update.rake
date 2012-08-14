namespace :twitter do
  task :update_avatars do
    Rake::Task[:environment].invoke 
    people = Dude.scoped
    people.each do |person|
      puts "Updating #{person.name}..."
      person.update_avatar!
    end
  end
  
  task :update_handle do
    Rake::Task[:environment].invoke 
    people_and_handles = [["Aaron Patterson", "tenderlove"], ["Damon Danieli", "damondanieli"], ["Dave Myron", "orngchkn"], ["Eric Hodel", "drbrain"], ["Eric Wong", "the_eric_wong"], ["Evan Phoenix", "evanphx"], ["Jack Danger Canty", "jackdanger"], ["John Barnette", "jbarnette"], ["Mike Mondragon", "monde"], ["Phil Hagelberg", "technomancy"], ["Wilson Bilkovich", "defiler"], ["Alex Vollmer", "alexvollmer"], ["Geoffrey Grosenbach", "topfunky"], ["Pete Higgins", "pete_higgins"]]
    people_and_handles.each do |name, handle|
      Dude.where(name: name).first.update_attributes(twitter: handle)
    end
  end
end

