require 'net/http/persistent'
namespace :rubygems do 

  task :update_dudes => :environment do

    dudes = Dude.all
    # dudes = Dude.recent
    dudes.each do |dude|
      uri = URI 'https://rubygems.org/api/v1/owners/' + dude.ruby_gems_id + '/gems.json'
      http = Net::HTTP::Persistent.new
      response = http.request uri
      response_array = ActiveSupport::JSON.decode(response.body) 
      response_array.each do |gem|
        puts gem['name']
        puts gem['info']
        puts gem['source_code_uri']
        puts gem['project_uri']
        if gem['source_code_url']
          gem_url = gem['source_code_uri']
        else
          gem_url = gem['project_uri']
        end
        # create or find the project
        project = Project.find_or_create_by_name(
          gem['name'],
          :url => gem_url,
          :description => gem['info'])
        # create or find the affiliation
        if !dude.projects.include? project
          dude.projects << project
          dude.save
        end
      end
    end
  end
end

