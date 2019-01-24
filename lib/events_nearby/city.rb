# City model
class EventsNearby::City
	attr_accessor :name, :state, :events
	@@all = []

	def initialize(name, state)
		@name = name
		@state = state
		@events = []
		@@all << self
	end

	# Adds new event to city array
	def add_event(event)
		self.events << event unless self.events.include?(event)
	end

	def self.all
		@@all
	end

	# Find city if city and state combination exist already
	def self.find_by(name, state)
		self.all.detect{|city| city.name == name && city.state == state}
	end

	# Parse user city input and return name of city and state
	def self.parse_city_input(city_input)
		data = city_input.split(/[\s,]+/)

		if city_input.include?(",")
				state = data.last.gsub(/[^0-9A-Za-z]/, '').upcase
				city_array = data.first data.size - 1
		else
				city_array = data
		end

		name = city_array.collect do |item|
				item.gsub(/[^0-9A-Za-z]/, '').capitalize
		end.join(" ")

		{name: name, state: state}
	end
end
