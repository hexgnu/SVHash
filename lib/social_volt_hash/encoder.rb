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
      if coordinates.length != dimension
        raise SocialHash::TooManyDimensionsError
      end
      #       
      # There seems to be a weird issue with ruby and this...
      # Don't do [range] * coordinates.length cause it'll cause
      # reference errors
      guesses = coordinates.length.times.map { [min,max] } 
      binary_coordinates = coordinates.length.times.map { [] }
        
      
      coordinates.each_with_index do |c, i|
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
      
      binary.to_i(2).to_s(36)
    end
    
    def find_binary(coordinate)
      binary = []
      minmax = [min,max]
      
      
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
