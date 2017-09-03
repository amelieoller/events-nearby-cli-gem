class EventsNearby::Events

    attr_accessor :name, :date, :price, :url, :content

    @@all = []

    def save
        @@all << self
    end

    def self.all
        @@all
    end

    def self.destroy_all
        self.all.clear
    end

    def self.today(input)
        EventsNearby::Scraper.new.include_location_in_url(input)
    end

    def content
        @content ||= EventsNearby::Scraper.new(url).scrape_event
    end

    def formatted_event
        "#{self.name} | #{self.date} | #{self.price}"
    end

    def open_in_browser
        system("xdg-open '#{url}'")
    end

end