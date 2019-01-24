class EventsNearby::Scraper
	def scrape_events(name, state)
		url = "https://www.eventbrite.com/d/#{state}--#{name.split(/[\s,]+/).join("-")}/all-events/"

		# Check if url is valid or returns error. If valid, scrape city, if not return false
		doc = nokogiri_error_handling(url)
		return false if doc == false

		city = EventsNearby::City.new(name, state)

		doc.search(".search-event-card-wrapper").each do |event_data|
			name = event_data.search(".card-text--truncated__three").text.strip
			url = event_data.search(".eds-media-card-content__action-link").attr('href').value
			date = event_data.search(".eds-text-bs--fixed")[0].text
			price = event_data.search(".eds-text-bs--fixed")[2].text

			event = EventsNearby::Event.new(name, date, price, url, city)
			city.add_event(event)
		end

		city
	end

	def scrape_event(event)
		doc = nokogiri_error_handling(event.url)
		event.content = doc.search(".js-xd-read-more-contents p").text.strip[0..300].gsub(/\s\w+\s*$/,'...')
	end

	def nokogiri_error_handling(url)
		openuri_params = {
			# set timeout durations for HTTP connection
			# default values for open_timeout and read_timeout is 60 seconds
			:open_timeout => 1,
			:read_timeout => 1,
		}

		attempt_count = 0
		max_attempts  = 3

		begin
			attempt_count += 1
			content = open(url, openuri_params).read
		rescue OpenURI::HTTPError => e
			# it's 404, etc. - puts out error & do nothing
			puts "We encountered a 404 error, please try again."
			false
		rescue SocketError, Net::ReadTimeout => e
			# server can't be reached or doesn't send any respones
			puts "error: #{e}"
			sleep 3
			retry if attempt_count < max_attempts
		else
			# connection successful, content is fetched, parse content with Nokogiri
			Nokogiri::HTML(content)
		end
	end
end
