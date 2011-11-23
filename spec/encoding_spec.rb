require File.expand_path("../spec_helper", __FILE__)
def round(num)
  (num * 10).round
end

describe "encoding" do
  it 'should encode a four dimensional array correctly' do
    e = SocialHash::Encoder.new(4, -2, 2)
    e.encode(-0.814453125, 1.560546875, -0.189453125, 0.310546875).should == "568ii5tr"
  end
  
  it 'should throw an error if given the wrong dimension' do
    lambda { SocialHash::Encoder.new(1, -2, 2) }.should raise_error(SocialHash::TooFewDimensionsError)
    lambda { SocialHash::Encoder.new(2, -2, 2).encode(1,2,3,4)}.should raise_error(SocialHash::IncorrectDimensionsError)
    lambda { SocialHash::Encoder.new(2, 2, -2) }.should raise_error(SocialHash::MaxMinBackwardsError)
  end
  
  it 'accepts an array instead of splatted arguments' do
    e = SocialHash::Encoder.new(4, -2, 2)
    e.encode([-0.814453125, 1.560546875, -0.189453125, 0.310546875]).should == "568ii5tr"
  end
  
  it 'throws MalformedDataError if not numeric' do
    e = SocialHash::Encoder.new(4, -2, 2)
    lambda { e.encode(%w[a b c d]) }.should raise_error(SocialHash::MalformedDataError)
    lambda { e.encode(nil,nil,nil,nil)}.should raise_error(SocialHash::MalformedDataError)
    lambda { e.encode(1, 2, 3,4) }.should_not raise_error(SocialHash::MalformedDataError)
    lambda { e.encode(1.0, 1.0, 1.0, 1.0)}.should_not raise_error(SocialHash::MalformedDataError)
  end
  
  context "base 10" do
    it 'returns an int for base 10' do
      SocialHash.configure do |c|
        c.base = 36
      end
      e = SocialHash::Encoder.new(4, -2, 2)
      first = e.encode(-0.814453125, 1.560546875, -0.189453125, 0.310546875)
      
      SocialHash.configure do |c|
        c.base = 10
      end
      
      e = SocialHash::Encoder.new(4, -2, 2)
      e.encode(-0.814453125, 1.560546875, -0.189453125, 0.310546875).should == first.to_i(36)
      
    end
    
    it 'returns the same numerical version for any base' do
      SocialHash.configure do |c|
        c.base = 36
      end
      e = SocialHash::Encoder.new(4, -2, 2)
      first = e.encode(-0.814453125, 1.560546875, -0.189453125, 0.310546875)

      SocialHash.configure do |c|
        c.base = 20
      end

      e = SocialHash::Encoder.new(4, -2, 2)
      e.encode(-0.814453125, 1.560546875, -0.189453125, 0.310546875).to_i(20).should == first.to_i(36)
    end
  end
end