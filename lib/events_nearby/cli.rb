# CLI Controller

class EventsNearby::CLI

    def call
        choose_city
    end

    def choose_city
        puts "What city would you like to see events nearby?"
        input = gets.strip
        if input != "exit"
            puts "This is a list of the events"
        else
            goodbye
        end
    end

    def goodbye
        puts "See you later!"
    end

end