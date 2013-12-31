require "google_map_directions/version"
require "google_map_directions/step"
require "open-uri"
require "json"

module GoogleMapDirections
  class Directions
    attr_accessor :origin, :destination, :sensor, :json, :paths
    @@base_google_url = 'http://maps.googleapis.com/maps/api/directions/json?'

    def initialize(origin, destination, sensor=false)      
      @origin = origin
      @destination = destination
      @sensor = sensor
      url = "#{@@base_google_url}&origin=#{@origin.gsub(/\s/,'+')}&destination=#{@destination.gsub(/\s/,'+')}&sensor=#{@sensor.to_s}"
      @json = JSON.parse(open(url).read)
      if status_check
        @legs = @json["routes"][0]["legs"][0]
        set_up_paths
      else
        @legs = nil
        @path = nil
      end
    end

    def status
      return @json["status"]      
    end 

    def distance_as_string
      if status_check then return @legs["distance"]["text"] else return nil end
    end

    def distance_in_meters
      if status_check then return @legs["distance"]["value"] else return nil end
    end

    def destination_coordinates
      if status_check then return @legs['end_location'] else return nil end
    end

    def origin_address
      if status_check then return @legs['start_address'] else return nil end
    end

    def destination_address
      if status_check then return @legs['end_address'] else return nil end
    end

    def origin_coordinates
      if status_check then return @legs['start_location'] else return nil end
    end


    def duration_as_string
      if status_check then return @legs['duration']['text'] else return nil end    
    end

    def duration_in_seconds
      if status_check then return @legs['duration']["value"] else return nil end   
    end

    def path_length
      if status_check then return @path.length else return nil end
    end

    def step(number)
      if status_check then return @path[number] else return nil end
    end


    private
    def status_check
      status == 'OK'
    end

    def set_up_paths
      @path = Array.new(@legs["steps"].length)
      count = 0
      @legs["steps"].each do |segment|
        @path[count] = GoogleMapDirections::Step.new(segment["distance"], segment["duration"], segment["end_location"], segment["start_location"], count, segment["html_instructions"])
        count = count + 1
      end
    end
  end
end
