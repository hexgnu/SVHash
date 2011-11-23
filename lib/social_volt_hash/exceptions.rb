module SocialHash
  class IncorrectDimensionsError < ArgumentError; end
  class TooFewDimensionsError < ArgumentError; end
  class TooManyDimensionsError < ArgumentError; end
  class MaxMinBackwardsError < ArgumentError; end
  class MalformedDataError < ArgumentError; end
end