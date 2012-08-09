namespace :twitter do
  task :update_avatars do
    Rake::Task[:environment].invoke 
    people = Dude.scoped
    people.each do |person|
      puts "Updating #{person.name}..."
      person.update_avatar!
    end
  end
end

