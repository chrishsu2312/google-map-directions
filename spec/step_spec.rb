require 'spec_helper'
describe GoogleMapDirections do
  describe "directions object should have a series of paths" do
    before(:all) do
      @test = GoogleMapDirections::Directions.new('Soda Hall Berkeley CA', 'Foothill Berkeley CA')
    end

    it "should have a certain number of steps in the route" do
      @test.path_length.should == 4
    end

    it "should be able to return a step of a route" do
      @test.step(0).class.should == GoogleMapDirections::Step
    end
  end

  describe "path object should have information about the route" do
    before(:all) do
      @test = GoogleMapDirections::Directions.new('Soda Hall Berkeley CA', 'Foothill Berkeley CA').step(0)
    end

    it "should give the distance of the step as a string" do
      @test.distance_as_string.should == "167 ft"
    end

    it "should give the duration of the step in seconds" do
      @test.duration_in_seconds.should == 5
    end
    it "should give the distance of the step as a value" do
      @test.distance_as_string.should == "167 ft"
    end

    it "should give the duration of the step as a vlue" do
      @test.distance_in_meters.should == 51
    end

    it "should give the end_location of the step" do
      @test.end_location.should == {"lat"=>37.87533519999999, "lng"=>-122.2583139}
    end

    it "should give the start_location of the step" do
      @test.start_location.should == {"lat"=>37.8757857, "lng"=>-122.2584081}
    end

    it "should give the number of the step" do
      @test.number.should == 0
    end

    it "should give the HTML_instructions of the step" do
      @test.HTML_instructions.should == "Head <b>south</b> on <b>Le Roy Ave</b> toward <b>Hearst Ave</b>"
    end
  end
end
