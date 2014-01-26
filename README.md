# Google Map Directions

A wrapper gem for the google directions API.
https://developers.google.com/maps/documentation/directions/

## Installation

Add this line to your application's Gemfile:

    gem 'google_map_directions'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install google_map_directions

## Usage

Currently, this gem only pulls a single route from the google directions api. The ability to search through multiple routes will be added at a later date.

Setup:
```Ruby
  directions = GoogleMapDirections::Directions.new('Soda Hall Berkeley CA', 'Foothill Berkeley CA')
```
You can check the status code to see if the request to the API was sucessful.
```Ruby
  directions.status
```
If you want to parse the data yourself, you can grab the ruby representation of the JSON object
```Ruby
  directions.json
```
There is a lot of basic information you can just get from the Directions object
```Ruby
  directions.distance_as_string
  directions.distance_in_meters

  directions.destination_coordinates
  directions.origin_coordinates   

  #The two coordinates methods return hashes that contain the latitude and longitude
  directions.destination_coordinates["lat"]
  directions.destination_coordinates["lng"]  


  directions.origin_address
  directions.destination_address
  directions.duration_as_string
  directions.duration_in_seconds
```
The steps of the route can be pulled from the step method
```Ruby
  directions.path_length
  #Returns the number of steps in the routes
  step1 = directions.step(0)
  #Returns the first step of the path  
  
  step1.distance_as_string
  step1.distance_in_meters
  step1.duration_as_string
  step1.duration_in_seconds


  step1.end_location
  step1.start_location

  #The two coordinates methods return hashes that contain the latitude and longitude
  step1.end_location["lat"]
  step1.end_location["lng"]  

  step1.number
  step1.HTML_instructions
```

Let me know of any bugs/additional features wanted.

NOTE: If the input addresses has brackets, you might have issues with parsing the address. Consider using gsub(/\(.*?\)/, '') to remove the brackets and the things inside them.
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
