# Events Nearby
Welcome to 'Events Nearby'! This repository contains a Ruby CLI (Command Line Interface) Gem. 'Events Nearby' lets you enter any location to retrieve a list of events that are near that location. Displayed will be the name of the events, when they are taking place, and how much they cost. You can then choose one of the listed events to see details about that event and open it in your browser.

![Events Nearby Walkthrough](./events-nearby-walkthrough.gif)

## Installation/Running the Application

### Option 1: Clone the Repository and Run It Directly
1. Clone this repository: `git clone https://github.com/amelieoller/events-nearby-cli-gem.git`
2. `cd` into the cloned directory
3. Run `bundle install` in your terminal
4. Then run the application with `bin/events_nearby`

### Option 2: Add the Gem to Your Gemfile

Add this line to your application's Gemfile:

```ruby
gem 'events_nearby'
```

And then run `bundle`

### Option 3: Install It Yourself
```bash
gem install events_nearby
```

## Usage

- Start the program
- Enter the location you want to see events nearby
- Enter a number to see more details about a specific event
- Open the chosen event in your browser if you wish or start over

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/amelieoller/events-nearby-cli-gem. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
