require 'yaml'
require_relative './city_finder/lib/city_finder.rb'
require_relative './vehicle.rb'

if ARGV.empty?
	print 'Plaka: '
	plate = gets.strip
	print 'Model: '
	model = gets.strip
	print 'Ad/Soyad: '
	name = gets.strip
	Vehicle.new(plate, model: model, name: name)
elsif ARGV.shift == '-s'
	plate = ARGV.join
	Vehicle.new(plate)
end
