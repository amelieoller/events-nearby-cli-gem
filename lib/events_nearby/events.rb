class EventsNearby::Events

    attr_accessor :name, :date, :price, :url, :content

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

    def content
        @content ||= EventsNearby::Scraper.new(url).scrape_event
    end

    def formatted_event
        "#{self.name} | #{self.date} | #{self.price}"
    end

    def open_in_browser
        system("open '#{url}'")
    end

end