if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start
  # For rails applications use
  # SimpleCov.start 'rails'
end
require File.expand_path("../../lib/social_volt_hash.rb", __FILE__)
