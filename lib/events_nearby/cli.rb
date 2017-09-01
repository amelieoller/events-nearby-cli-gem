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
        puts <<-DOC
            1. Beer Tasting & Social Meetup | Sep 02 | San Francisco, CA | $30
            2. Hofbrauhaus Munich Saturdays | Sep 02 | San Francisco, CA | Free
            3. SF Bay Brazilian Day & Lavagem 2017 | Sep 03 | Berkeley, CA | $45
            4. Labor Day Sail ~ Bloody Marys on San Francisco Bay | Sep 04 | Sausalito, CA | $75-$89
            5. Brooklyn Meets The Bay Day Fest | Sep 04 | Oakland, CA | Free
        DOC
        menu
    end

    def menu
        puts "Which event would you like to know more about? Enter a number or 'exit'"
        input = gets.strip

        if input.to_i.between?(1,5)  # Put events.all.size for how many events are in the array
            puts "The selected event"
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