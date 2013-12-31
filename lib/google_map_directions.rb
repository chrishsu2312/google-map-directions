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
      return @legs["distance"]["text"] unless !status_check
    end

    def distance_in_meters
      return @legs["distance"]["value"] unless !status_check
    end

    def destination_coordinates
      return @legs['end_location'] unless !status_check
    end

    def origin_address
      return @legs['start_address'] unless !status_check
    end

    def destination_address
      return @legs['end_address'] unless !status_check
    end

    def origin_coordinates
      return @legs['start_location'] unless !status_check
    end


    def duration_as_string
      return @legs['duration']['text'] unless !status_check    
    end

    def duration_in_seconds
      return @legs['duration']["value"] unless !status_check   
    end

    def path_length
      return @path.length unless !status_check
    end

    def step(number)
      return @path[number] unless !status_check
    end


    private
    def status_check
      if status != 'OK'
        return false
      else
        return true
      end
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
