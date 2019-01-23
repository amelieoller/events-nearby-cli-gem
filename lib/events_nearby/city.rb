# City model
class EventsNearby::City
	attr_accessor :name, :state, :events
	@@all = []

	def initialize(name, state)
		@name = name
		@state = state
		@@all << self
	end

	def self.all
		@@all
	end

	def self.find_by(name, state)
		self.all.detect{|city| city.name == name && city.state == state}
	end

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
