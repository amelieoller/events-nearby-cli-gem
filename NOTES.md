# How to Build a CLI Gem

1. Plan your gem, imagine your interface
2. Start with the project structure - google
3. Start with the entry point - the file run
4. Force that to build the CLI interface
5. Stub out the interface
6. Start making things real
7. Discover objects
8. Program


## Plan your gem, imagine your interface

- A command line interface for events nearby


User types in events-nearby

What city would you like to see events nearby?
    
Show a list of top events near the entered city

1. Beer Tasting & Social Meetup | Sep 02 | San Francisco, CA | $30
2. Hofbrauhaus Munich Saturdays | Sep 02 | San Francisco, CA | Free
3. SF Bay Brazilian Day & Lavagem 2017 | Sep 03 | Berkeley, CA | $45
4. Labor Day Sail ~ Bloody Marys on San Francisco Bay | Sep 04 | Sausalito, CA | $75-$89
5. Brooklyn Meets The Bay Day Fest | Sep 04 | Oakland, CA | Free

What would you like to know more about? Enter number or 'exit'.

--- Beer Tasting & Social Meetup | Sep 02 | San Francisco, CA | $30

--- Description
Let's get together and try some of the best micro brews in the US. Santa Rosa (where I'm originally from!) just recently got awarded the capitol of micro brews in the US.

Would you like to open this event or see the list again? Enter 'open', 'list' or 'exit'.