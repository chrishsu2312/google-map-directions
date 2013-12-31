module GoogleMapDirections
  class Step
    attr_reader :distance, :duration, :end_location, :start_location, :number, :HTML_instructions

    def initialize(distance, duration, end_location, start_location, number, html_instructions)
      @distance = distance
      @duration = duration
      @end_location = end_location
      @start_location = start_location
      @number = number
      @HTML_instructions = html_instructions
    end

    def distance_as_string
      return @distance["text"]
    end
    def distance_in_meters
      return @distance["value"]
    end
    def duration_as_string
      return @duration["text"]
    end
    def duration_in_seconds
      return @duration["value"]
    end
  end

end
