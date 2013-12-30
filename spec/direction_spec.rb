require 'spec_helper'
describe GoogleMapDirections do

  describe "connecting to the google directions api successfully" do
    before(:each) do
      @test = GoogleMapDirections::Directions.new('UC Berkeley, Berkeley, CA', '1600 Amphitheatre Pkwy, Mountain View')
      sleep(0.1) #make sure you don't spam the api too quickly
    end

    it 'should successfully create itself' do
      @test.should_not == nil
    end
    it 'should have success code of OK' do
      @test.status.should == 'OK'
    end
  end

  describe "possible bad statuses" do
    it 'should indicate a start or end point that is not found' do
      sleep(0.1) #make sure you don't spam the api too quickly      
      GoogleMapDirections::Directions.new('herpderprawrs31415', '1600 Amphitheatre Pkwy, Mountain View').status.should == "NOT_FOUND"
    end
    it 'should indicate that a path does not exist' do
      sleep(0.1) #make sure you don't spam the api too quickly
      GoogleMapDirections::Directions.new('New York, New York', 'Beijing, China').status.should == "ZERO_RESULTS"
    end
  end

  describe "pulling correct information from api" do
    before(:all) do
      @happy_path = GoogleMapDirections::Directions.new('UC Berkeley, Berkeley, CA', '1600 Amphitheatre Pkwy, Mountain View')
      sleep(0.1) #make sure you don't spam the api too quickly
      @sad_path = GoogleMapDirections::Directions.new('super nyan cat', 'flying cattle from mars 3125herpderp')
      sleep(0.1) #make sure you don't spam the api too quickly
    end
    it 'should correctly give distances as a string' do
      @happy_path.distance_as_string.should == "42.3 mi"
    end
    it 'should correctly give distances in meters' do
      @happy_path.distance_in_meters.should == 68130
    end
    it 'should correctly give the coordinates of the destination' do
      @happy_path.destination_coordinates.should == {
        "lat" => 37.4212053,
        "lng" => -122.0840357
      }
    end
    it 'should correctly give the coordinates of the origin' do
      @happy_path.origin_coordinates.should == {
        "lat" => 37.8688419,
        "lng" => -122.2582396
      }
    end
    it 'should correctly give the address of the destination' do
      @happy_path.origin_address.should == "University of California, Berkeley, Berkeley, CA"
    end
    it 'should correctly give the address of the origin' do
      @happy_path.destination_address.should == "1600 Amphitheatre Parkway, Mountain View, CA 94043, USA"

    end 
    it 'should correctly give the duration of the trip as a string' do 
      @happy_path.duration_as_string.should == "55 mins"
    end
    it 'should correctly give the duration of the trip in minutes' do 
      @happy_path.duration_in_minutes.should == 3322
    end
    it 'should correctly give distances as a string for a bad reply' do
      @sad_path.distance_as_string.should == nil
    end
    it 'should correctly give distances in meters for a bad reply' do
      @sad_path.distance_in_meters.should == nil
    end
    it 'should correctly give the coordinates of the destination for a bad reply' do
      @sad_path.destination_coordinates.should == nil
    end
    it 'should correctly give the coordinates of the origin for a bad reply' do
      @sad_path.origin_coordinates.should == nil
    end
    it 'should correctly give the address of the destination for a bad reply' do
      @sad_path.origin_address.should == nil
    end
    it 'should correctly give the address of the origin for a bad reply' do
      @sad_path.destination_address.should == nil

    end 
    it 'should correctly give the duration of the trip as a string for a bad reply' do 
      @sad_path.duration_as_string.should == nil
    end
    it 'should correctly give the duration of the trip in minutes for a bad reply' do 
      @sad_path.duration_in_minutes.should == nil
    end
  end




end
