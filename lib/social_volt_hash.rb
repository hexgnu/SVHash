require File.expand_path("../social_volt_hash/decoder", __FILE__)
require File.expand_path("../social_volt_hash/encoder", __FILE__)
require File.expand_path("../social_volt_hash/exceptions", __FILE__)
require File.expand_path("../social_volt_hash/version", __FILE__)
module SocialHash
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :base

    def initialize
      @base = 36
    end
  end
end

SocialHash.configure do |c|
  c.base = 36
end