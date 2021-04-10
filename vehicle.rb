class Vehicle
	

	def initialize(plate, **others) 
		if others.empty?
			@plate = plate.upcase.gsub(' ', '')
			find_vehicle
		else
			@plate = plate.upcase.gsub(' ', '')
			@city  = CityFinder.new(plate).city
			@model = others[:model] if valid_model?(others[:model])
			@name  = others[:name]

			if not is_exist?
				save_to_yaml_file
				puts "#{@plate} vehicle was added."
			end
		end
	end

	private

	def find_vehicle
		existed_vehicles = YAML.load_stream(File.read('vehicles.yml'))
		found_vehicles = existed_vehicles.select {|vehicle| vehicle['plate'] == @plate }
		if found_vehicles.empty?
			puts "#{@plate} plakali arac sistemde yok."
		else
			vehicle = found_vehicles.first
			puts "#{vehicle['name']} - #{vehicle['city']} - #{vehicle['model']} - #{vehicle['plate']}"
		end
	end

	def is_exist?
		existed_vehicles = YAML.load_stream(File.read('vehicles.yml'))
		found = false
		existed_vehicles.each do |vehicle|
			found = true if vehicle['plate'] == @plate
		end
		if found 
			puts 'Bu plakali arac var.'
			exit
		else
			return false
		end
	end

	def save_to_yaml_file
		yaml_output = YAML.dump({
			'name'  => @name,
			'city'  => @city,
			'model' => @model,
			'plate' => @plate,
		})
		File.write('vehicles.yml', yaml_output, mode: 'a')
	end

	def valid_model?(model)
		model_names = []
		MODELS.each do |model|
			model_names.push(model['name'])
		end
		
		if model_names.include?(model.upcase)
			return true
		else
			puts 'Bulunmayan arac modeli.'
			exit
		end
	end
end
