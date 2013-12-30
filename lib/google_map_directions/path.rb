module GoogleMapDirections
  class Path
    attr_reader :distance, :duration, :end_location, :start_location, :number, :HTML_instructions

    def initialize(distance, duration, end_location, start_location, number, html_instructions)
      @distance = distance
      @duration = duration
      @end_location = end_location
      @start_location = start_location
      @number = number
      @HTML_instructions = html_instructions
    end
  end
end
