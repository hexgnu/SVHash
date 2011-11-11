require 'rspec/core/rake_task'
desc 'Default: run specs.'
task :default => :spec

desc "Run specs"
RSpec::Core::RakeTask.new

desc "Run tests with SimpleCov"
RSpec::Core::RakeTask.new('coverage') do |t|
  ENV['COVERAGE'] = "true"
  require 'simplecov'
end
$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "social_volt_hash/version"
 
task :build do
  system "gem build social_volt_hash.gemspec"
end