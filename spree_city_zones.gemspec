Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_city_zones'
  s.version     = '1.1.0'
  s.summary     = 'Spree extension providing tax zones based on city name'
  s.description = 'This spree extension helps with setting up tax zones based on city name. It should be useful for setting up the different tax zones as mandated by Calinfornia state law in the United States.'
  s.required_ruby_version = '>= 1.8.7'

  s.author            = 'Mark Linn'
  s.email             = 'marklinn@xwcsolutions.com'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency('spree_core', '~> 1.1.0')
  s.add_dependency('rails', '~> 3.2.3')
end
