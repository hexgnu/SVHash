lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'social_volt_hash/version'

Gem::Specification.new do |s|
  s.name          = "SocialVoltHash"
  s.version       = SocialVolt::Hash::Version
  s.platform      = Gem::Platform::RUBY
  s.authors       = ["Matt Kirk"]
  s.email         = ["matt@socialvolt.com"]
  s.summary       = "Multi-dimensional hashing algorithm"
  s.description   = "Given a row of multi dimensional data between a max and min, we will return a hash that can be sorted"
  
  s.add_development_dependency  "rspec"
  s.add_development_dependency "simplecov"
  s.files         = Dir.glob("{lib}/**/*") + %w[LICENSE README.md ROADMAP.md CHANGELOG.md]
  s.require_path  = "lib"
end