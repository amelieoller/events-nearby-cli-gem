# Event model
class EventsNearby::Event
	attr_accessor :name, :date, :price, :url, :city, :content
	@@all = []

	def initialize(name, date, price, url, city)
		@name = name
		@date = date
		@price = price
		@url = url
		@city = city
		@@all << self
	end

	def self.all
		@@all
	end

	def format_event
		"#{self.name} | #{self.date} | #{self.price}"
	end

	def open_in_browser
		Launchy.open(url)
	end
end
