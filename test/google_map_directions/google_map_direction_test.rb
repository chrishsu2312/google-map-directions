require 'helper'
 
describe GoogleMapDirections do
  before(:each) do
    @test = GoogleMapDirections::Directions.new('UC Berkeley, Berkeley, CA', '1600 Amphitheatre Pkwy, Mountain View')
  end

  it 'should have a version' do
    GoogleMapDirections::VERSION.wont_be_nil
  end

  it 'should successfully create itself' do
    @test.wont_be_nil    
  end

  it 'should have success code of OK' do
    @test.status.must_equal('OK')
  end

  it 'should have success code of OK' do
    @test.status.must_equal('OK')
  end
  


end
