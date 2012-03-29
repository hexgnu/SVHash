module SocialHash
  class Encoder < Struct.new(:dimension, :min, :max)
    def initialize(*args)
      if args.first < 2
        raise SocialHash::TooFewDimensionsError
      end
      
      if args[1] >= args[2]
        raise SocialHash::MaxMinBackwardsError
      end
      super
    end
    
    def encode(*coordinates)
      
      coords = Array(coordinates).flatten
      if coords.length != dimension
        raise SocialHash::IncorrectDimensionsError, "Coordinates given #{coords.length} does not equal #{dimension} dimension"
      end
      #       
      # There seems to be a weird issue with ruby and this...
      # Don't do [range] * coordinates.length cause it'll cause
      # reference errors
      guesses = coords.length.times.map { [min,max] } 
      binary_coordinates = coords.length.times.map { [] }
        
      
      coords.each_with_index do |c, i|
        binary_coordinates[i].concat(find_binary(c))
      end
      
      binary = '0'
      
      done = [false] * coordinates.length
      while done.include?(false)
        binary_coordinates.each_with_index do |ba, i|
          if ba.empty?
            done[i] = true
          else
            binary += ba.shift
          end
        end
      end
      
      binary.to_i(2).to_s(Geomash::BASE)
    end
    
    def find_binary(coordinate)
      binary = []
      minmax = [min,max]
      if !coordinate.kind_of?(Numeric)
        raise MalformedDataError, "Was given a coordinate of type #{coordinate.class} instead of being a Numeric"
      end
      
      while binary.length < 10
        mid = (minmax[0] + minmax[1]).to_f / 2
        if coordinate > mid
          binary << "1"
          minmax[0] = mid
        else
          binary << "0"
          minmax[1] = mid
        end
      end
      binary
    end
  end
end
