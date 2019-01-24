# CLI Controller
class EventsNearby::CLI
	# Ask user for city input, find or create new city and set @city instance variable
	def choose_city
		puts "What city would you like to see events nearby? (e.g. 'San Francisco, CA')"

		input = gets.strip.downcase
		parsed_input = EventsNearby::City.parse_city_input(input)
		name = parsed_input[:name]
		state = parsed_input[:state]

		if EventsNearby::City.find_by(name, state)
			@city = EventsNearby::City.find_by(name, state)
			list_events
		else
			@city = EventsNearby::Scraper.new.scrape_events(name, state)
			@city == false ? choose_city : list_events
		end
	end

	def list_events
		separator
		puts "These are the upcoming events for #{@city.name.bold}:".red
		separator

		@city.events.each_with_index do |event, i|
			puts "#{i+1}. #{event.format_event}"
		end

		menu
	end

	def menu
		separator
		puts "What would you like to do next?"
		puts "- Pick an event by entering a number".bold
		puts "- Type " + "'city'".bold + " to choose a new city"
		puts "- Type " + "'list'".bold + " to list all events again"
		puts "- Type " + "'exit'".bold + " to exit"
		separator

		input = gets.strip

		if input == "exit"
			puts "See you later!"
		elsif input == "list"
			list_events
		elsif input == "city"
			choose_city
		elsif input.to_i.between?(1, @city.events.size)
			event = @city.events[input.to_i - 1]
			EventsNearby::Scraper.new.scrape_event(event) unless event.content
			show_details(event)
		else
			puts "Not sure what you mean..."
			menu
		end
	end

	def show_details(event)
		puts ""
		puts "--- #{event.format_event} ---".green
		puts event.content
		puts ""
		separator
		puts "Would you like to open this event in your browser? #{'yes'.bold} or #{'no'.bold}?"
		separator

		input = gets.strip.downcase

		if ["y", "yes", "open"].include?(input)
			event.open_in_browser
			puts ""
			menu
		else
			menu
		end
	end

	def separator
		puts "--------------**********--------------".red
	end
end
