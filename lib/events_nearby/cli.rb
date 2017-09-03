# CLI Controller

class EventsNearby::CLI

    def call 
        choose_city
    end

    def choose_city
        puts "What city would you like to see events nearby? (e.g. 'San Francisco, CA')"
        input = gets.strip.downcase
        EventsNearby::Events.destroy_all
        EventsNearby::Events.today(input)
        input == "exit" ? goodbye : list_events(input)
    end

    def list_events(city)
        puts "These are the upcoming events for #{city}:"
        
        EventsNearby::Events.all.each_with_index do |event, i|
            puts "#{i+1}. #{event.formatted_event}"
        end
        menu
    end

    def menu
        puts "Which event would you like to know more about? Enter a number, 'start' to start over, or 'exit'."
        input = gets.strip
        if input.to_i.between?(1, EventsNearby::Events.all.size)
            event = EventsNearby::Events.all[input.to_i - 1]
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