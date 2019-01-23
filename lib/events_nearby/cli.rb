# CLI Controller

class EventsNearby::CLI

	def call
		choose_city
	end

	def choose_city
		puts "What city would you like to see events nearby? (e.g. 'San Francisco, CA')"
		input = gets.strip.downcase
		parsed_input = EventsNearby::City.parse_city_input(input)
		name = parsed_input[:name]
		state = parsed_input[:state]

		if EventsNearby::City.find_by(name, state)
			city = EventsNearby::City.find_by(name, state)
		else
			city = EventsNearby::City.new(name, state)
			EventsNearby::Scraper.new.scrape_events(city)
		end

		input == "exit" ? goodbye : list_events(city)
	end

	def list_events(city)
		puts "These are the upcoming events for #{city.name}:"

		EventsNearby::Event.all.each_with_index do |event, i|
			puts "#{i+1}. #{event.formatted_event}"
		end
		menu
	end

	def menu
		puts "Which event would you like to know more about? Enter a number, 'start' to start over, or 'exit'."
		input = gets.strip
		if input.to_i.between?(1, EventsNearby::Event.all.size)
			event = EventsNearby::Event.all[input.to_i - 1]
			EventsNearby::Scraper.new.scrape_event(event) unless event.content
			show_details(event)
		else
			decision(input)
		end
	end

	def show_details(event)
		puts ""
		puts "--- #{event.formatted_event} ---"
		if event.content != ""
			puts event.content
			puts ""
			puts "Would you like to open this event in your browser? Enter 'yes' to open, 'menu' to pick another event, 'start' to start over, or 'exit'."
			input = gets.strip
			open_in_browser_decision(input, event)
		else
			puts "There seems to be no description of this event. Would you like to open this event in your browser? Enter 'yes' to open, 'menu' to pick another event, 'start' to start over, or 'exit'."
			input = gets.strip
			open_in_browser_decision(input, event)
		end
	end

	def open_in_browser_decision(input, event)
		if ['y', 'yes', 'open'].include?(input.downcase)
			event.open_in_browser
			puts ""
			menu
		else
			decision(input)
		end
	end

	def decision(input)
		case input
		when "exit"
			goodbye
		when "menu"
			menu
		when "start"
			choose_city
		else
			puts "Not sure what you mean. Enter 'menu' to pick another event, 'start' to start over, or 'exit'."
			decision(gets.strip)
		end
	end

	def goodbye
		puts "See you later!"
	end
end
