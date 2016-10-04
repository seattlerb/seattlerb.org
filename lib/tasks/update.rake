namespace :twitter do
  task :update_avatars do
    Rake::Task[:environment].invoke
    people = Member.scoped
    people.each do |person|
      puts "Updating #{person.name}..."
      person.update_avatar!
      puts person.image_url
    end
  end
end
