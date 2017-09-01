require_relative '../../config/environment'

class EventsNearby::Scraper

    def initialize(url = nil)
        @url = url
    end

    def scrape_event
        @doc = Nokogiri::HTML(open(@url))
        @doc.search(".js-xd-read-more-contents p").text.strip[0..300].gsub(/\s\w+\s*$/,'...')
    end

    def include_location_in_url(location)
        data = location.split(/[\s,]+/)
        state = data.last.gsub(/[^0-9A-Za-z]/, '')
        city_array = data.first data.size - 1        
        city = city_array.collect do |item|
            item.gsub(/[^0-9A-Za-z]/, '')
        end.join("-")
        url = "https://www.eventbrite.com/d/#{state}--#{city}/events/"
        scrape_events(url)
    end

    def scrape_events(url)
        @doc = Nokogiri::HTML(open("#{url}"))
        @doc.search("div.js-event-list-container div.list-card-v2").each do |event_item|
            event = EventsNearby::Events.new

            event.name = event_item.search(".list-card__title").first.text.gsub("\n", "").strip
            event.date = event_item.search(".list-card__date").first.text.gsub("\n", "").strip.split.join(" ")
            event.price = event_item.search(".list-card__label").first.text.strip
            event.url = event_item.attr("data-share-url").strip

            event.save
        end
    end
    
end