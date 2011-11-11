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
    lambda { SocialHash::Encoder.new(2, -2, 2).encode(1,2,3,4)}.should raise_error(SocialHash::TooManyDimensionsError)
    lambda { SocialHash::Encoder.new(2, 2, -2) }.should raise_error(SocialHash::MaxMinBackwardsError)
  end
end