require "google_map_directions/version"
require "google_map_directions/path"
require "open-uri"
require "json"

module GoogleMapDirections
  class Directions

    attr_accessor :origin, :destination, :sensor
    attr_reader :json
    @@base_google_url = 'http://maps.googleapis.com/maps/api/directions/json?'

    def initialize(origin, destination, sensor = false)      
      @origin = origin.gsub(/\s/,'+')
      @destination = destination.gsub(/\s/,'+')
      @sensor = sensor.to_s
      url = "#{@@base_google_url}&origin=#{@origin}&destination=#{@destination}&sensor=#{@sensor}"
      @json = JSON.parse(open(url).read)
      @legs = (status_check ? @json["routes"][0]["legs"][0] : nil)
      @paths = nil
      set_up_paths
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

    def duration_in_minutes
      if status_check then return @legs['duration']["value"] else return nil end   
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
      if status_check
        @path = Array.new(@legs["steps"].length)
        count = 0
        @legs["steps"].each do |segment|
          @path[count] = GoogleMapDirections::Path.new(segment["distance"], segment["duration"], segment["end_location"], segment["start_location"], count, segment["html_instructions"])
          count = count + 1
        end
      end
    end
  end
end
