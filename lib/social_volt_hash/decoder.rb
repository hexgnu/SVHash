module SocialHash
  class Decoder < Struct.new(:dimension, :min, :max)
    def initialize(*args)
      if args.first < 2
        raise SocialHash::TooFewDimensionsError
      end
      
      if args[1] >= args[2]
        raise SocialHash::MaxMinBackwardsError
      end
      
      super
      
    end
    
    
    def decode(hash)
      binary = ("0" + hash.to_i(36).to_s(2)).split(//)
      coordinates = dimension.times.map {|_| [] }
      
      binary.each_slice(dimension) do |slice|
        slice.each_with_index do |coord, index|
          coordinates[index].push(coord)
        end
      end
      
      coordinates.map {|c| coordinate(c) }
    end
    
    def coordinate(binary)
      output = (max + min).to_f / 2
      current_range = (min..max)
  
      binary.each do |bit|
        if bit == "1"
          # Take right half
          current_range = (output..current_range.max)
          output = (output + current_range.max.to_f) / 2
        else
          current_range = (current_range.min..output)
          output = (output + current_range.min.to_f) / 2
        end
      end
  
      output
    end
  end
end