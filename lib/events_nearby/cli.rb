# CLI Controller

class EventsNearby::CLI

    def call
        choose_city
    end

    def choose_city
        puts "What city would you like to see events nearby?"
        input = gets.strip
        if input != "exit"
            list_events(input)
        else
            goodbye
        end
    end

    def list_events(city)
        puts "These are the upcoming events for #{city}:"
        EventsNearby::Events.today
        EventsNearby::Events.all.each_with_index do |event, i|
            puts "#{i+1}. #{event.formatted_event}"
        end
        menu
    end

    def menu
        puts "Which event would you like to know more about? Enter a number or 'exit'"
        input = gets.strip

        if input.to_i.between?(1, EventsNearby::Events.all.size)
            event = EventsNearby::Events.all[input.to_i - 1]
            puts ""
            puts "--- #{event.formatted_event} ---"
            if event.content != ""
                puts event.content
            else
                puts "There seems to be no description of this event."
            end
            puts ""
            menu
        elsif input == "list"
            list_events
        else
            puts "Not sure what you mean. Type 'list' or 'exit'."
        end
        goodbye
    end

    def goodbye
        puts "See you later!"
    end

end