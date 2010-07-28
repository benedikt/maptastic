require 'lib/maptastic/version'

Gem::Specification.new do |s|
  s.name          = "maptastic"
  s.version       = Maptastic::VERSION
  s.platform      = Gem::Platform::RUBY
  s.authors       = ["Benedikt Deicke"]
  s.email         = ["benedikt@synatic.net"]
  s.homepage      = "http://github.com/benedikt/maptastic"
  s.summary       = "Simple and unobtrusive map integration plugin for Ruby on Rails"
  s.description   = "The maptastic plugin for Ruby on Rails provides simple and unobtrusive helper methods and javascript libraries to integrate maps in web applications."

  s.has_rdoc      = true
  s.rdoc_options  = ['--main', 'README.rdoc', '--charset=UTF-8']
  s.extra_rdoc_files = ['README.rdoc', 'LICENSE']

  s.files         = Dir.glob('{lib,spec}/**/*') + %w(LICENSE README.rdoc Rakefile Gemfile Gemfile.lock .rspec)

  s.add_runtime_dependency('rails', ['>= 3.0.0.rc'])
  s.add_development_dependency('rspec', ['>= 2.0.0.beta.18'])
  s.add_development_dependency('rspec-rails', ['>= 2.0.0.beta.18'])
  s.add_development_dependency('autotest', ['>= 4.3.2'])
  s.add_development_dependency('hanna', ['>= 0.1.12'])
end
