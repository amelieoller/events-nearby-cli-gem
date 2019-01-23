# Event model
class EventsNearby::Event
	attr_accessor :name, :date, :price, :url, :content, :city
	@@all = []

	def initialize
		@@all << self
	end

	def self.all
		@@all
	end

	def formatted_event
		"#{self.name} | #{self.date} | #{self.price}"
	end

	def open_in_browser
		system("xdg-open '#{url}'")
	end
end
