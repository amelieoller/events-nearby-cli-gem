class EventsNearby::Scraper
	def scrape_events(city)
		puts "********* SCRAPING events *********"
		url = "https://www.eventbrite.com/d/#{city.state}--#{city.name.split(/[\s,]+/).join("-")}/all-events/"
		doc = Nokogiri::HTML(open("#{url}"))

		doc.search(".search-event-card-wrapper").each do |event_data|
			event = EventsNearby::Event.new

			event.name = event_data.search(".card-text--truncated__three").text.strip
			event.url = event_data.search(".eds-media-card-content__action-link").attr('href').value
			event.date = event_data.search(".eds-text-bs--fixed")[0].text
			event.price = event_data.search(".eds-text-bs--fixed")[2].text
		end
	end

	def scrape_event(event)
		puts "********* SCRAPING event *********"
		doc = Nokogiri::HTML(open(event.url))
		event.content = doc.search(".js-xd-read-more-contents p").text.strip[0..300].gsub(/\s\w+\s*$/,'...')
	end
end
