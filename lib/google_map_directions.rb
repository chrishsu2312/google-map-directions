require "google_map_directions/version"
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
    end

    def status
      return @json["status"]      
    end

    def distance_as_string
      status_check
      return @json["routes"][0]["legs"][0]["distance"]["text"]
    end

    def distance_in_meters
      status_check
      return @json["routes"][0]["legs"][0]["distance"]["value"]
    end

    def destination_coordinates
      status_check
      return @json["routes"][0]["legs"][0]['end_location']
    end

    def origin_address
      status_check
      return @json["routes"][0]["legs"][0]['start_address']
    end
    
    def destination_address
      status_check
      return @json["routes"][0]["legs"][0]['end_address']
    end

    def origin_coordinates
      status_check
      return @json["routes"][0]["legs"][0]['start_location']
    end
  end

  def duration_as_string
    status_check
    return @json["routes"][0]["legs"][0]['start_location']
  end

  def duration_in_minutes
    status_check
    return @json["routes"][0]["legs"][0]['duration']["value"]      
  end

  private

  def status_check
    if status != 'OK'
      return nil
    end
  end

end
