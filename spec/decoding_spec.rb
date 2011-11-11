require File.expand_path("../spec_helper", __FILE__)
def round(num)
  (num * 10).round
end


describe "Decoding" do
  it 'should be able to create a decoder obj' do
  
    # takes in dimensions, min, max
    d = SocialHash::Decoder.new(4, -2, 2)
  end
  
  it 'should decode 8qgzm into two coordinates of 42.6 and -2.8' do
    d = SocialHash::Decoder.new(2, -90, 90)
    d.decode("8qgzm").map do |c|
      round(c)
    end.should == [-28, 426]
  end

  it 'should decode 8abc to be' do
    d = SocialHash::Decoder.new(4, -2, 2)
  
    d.decode("8abc").length.should == 4
    d.decode("8abc").each do |e|
      (-2..2).should include e
    end
  
    d.decode("8abc").should == [-0.8125, 1.5625, -0.1875, 0.3125]
  end
  
  context "Coordinate" do
    it 'should be able to get  101111001001 into 42.6' do
      d = SocialHash::Decoder.new(2, -90, 90)
      round(d.coordinate("101111001001".split(//))).should == 426
    end

    it 'should be able to take a range between -2 and 2' do 
      d2 = SocialHash::Decoder.new(2, -2, 2)   
      d2.coordinate("101".split(//)).should == 0.75
    end

    it 'should throw an error for anything thats not binary' do
      d = SocialHash::Decoder.new(2, -90, 90)
      lambda { d.coordinate("1234") }.should raise_error
    end

    it 'should return the right result for' do
      d = SocialHash::Decoder.new(2, -90, 90)
      array = ["0", "1", "1", "1", "1", "1", "0", "0", "0", "0", "0", "0", "0"]
      round(d.coordinate(array)).should == -28
      array = ["1", "0", "1", "1", "1", "1", "0", "0", "1", "0", "0", "1"]
      round(d.coordinate(array)).should == 426
    end
    
    it 'should raise exceptions if too little dimensions' do
      lambda { SocialHash::Decoder.new(1, -90, 90) }.should raise_error(SocialHash::TooFewDimensionsError)
      lambda { SocialHash::Decoder.new(2, 90, -90) }.should raise_error(SocialHash::MaxMinBackwardsError)
    end
  end
end