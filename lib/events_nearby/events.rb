class EventsNearby::Events

    attr_accessor :name, :date, :price, :url

    @@all = []

    def save
        @@all << self
    end

    def self.all
        @@all
    end

    def self.today
        EventsNearby::Scraper.new.scrape_events
    end

end