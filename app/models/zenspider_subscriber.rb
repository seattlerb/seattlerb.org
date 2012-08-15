class ZenspiderSubscriber
  include HTTParty
  base_uri 'lists.zenspider.com/mailman'

  class << self
    def subscribe!(options)
      subscribe_to_discussion options[:person] if options[:subscribe_to_discussion]
      subscribe_to_jobs options[:person] if options[:subscribe_to_jobs]
    end

    private

    def subscribe_to_discussion(person)
      post "/subscribe/ruby", query: person
    end

    def subscribe_to_jobs(person)
      post "/subscribe/rubyjobs", query: person
    end
  end
end
