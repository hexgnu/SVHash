module SocialHash
  class IncorrectDimensionsError < ArgumentError
    def initialize(message)
      super(message)
    end
  end
  
  class TooFewDimensionsError < ArgumentError; end
  class TooManyDimensionsError < ArgumentError; end
  class MaxMinBackwardsError < ArgumentError; end
end