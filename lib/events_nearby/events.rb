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
        puts <<-DOC
            1. Beer Tasting & Social Meetup | Sep 02 | San Francisco, CA | $30
            2. Hofbrauhaus Munich Saturdays | Sep 02 | San Francisco, CA | Free
            3. SF Bay Brazilian Day & Lavagem 2017 | Sep 03 | Berkeley, CA | $45
            4. Labor Day Sail ~ Bloody Marys on San Francisco Bay | Sep 04 | Sausalito, CA | $75-$89
            5. Brooklyn Meets The Bay Day Fest | Sep 04 | Oakland, CA | Free
        DOC
    end

end