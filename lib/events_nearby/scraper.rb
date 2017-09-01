require_relative '../../config/environment'

class EventsNearby::Scraper

    def initialize(url = nil)
        @url = url
    end

    def scrape_event(url)
        @doc = Nokogiri::HTML(open(@url))
        @doc.search(".js-xd-read-more-contents").text
    end

    def scrape_events
        @doc = Nokogiri::HTML(open("https://www.eventbrite.com/d/ca--san-francisco/events/"))
        @doc.search("div.js-event-list-container div.list-card-v2").each do |event_item|
            event = EventsNearby::Events.new

            event.name = event_item.search(".list-card__title").first.text.gsub("\n", "").strip
            event.date = event_item.search(".list-card__date").first.text.gsub("\n", "").strip
            event.price = event_item.search(".list-card__label").first.text.strip
            event.url = event_item.attr("data-share-url").strip

            event.save
        end
    end
    
end