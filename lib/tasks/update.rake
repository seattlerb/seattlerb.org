namespace :twitter do
  desc "update twitter avatars"
  task :update_avatars do
    Rake::Task[:environment].invoke
    people = Member.verified
    people.each do |person|
      puts "Updating #{person.name}..."
      person.update_avatar!
      puts person.image_url
    end
  end
end
