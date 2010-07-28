require 'lib/maptastic/version'

Gem::Specification.new do |s|
  s.name          = "maptastic"
  s.version       = Maptastic::VERSION::STRING
  s.platform      = Gem::Platform::RUBY
  s.authors       = ["Benedikt Deicke"]
  s.email         = ["benedikt@synatic.net"]
  s.homepage      = "http://github.com/benedikt/maptastic"
  s.summary       = "Simple and unobtrusive map integration plugin for Ruby on Rails"
  s.description   = "The maptastic plugin for Ruby on Rails provides simple and unobtrusive helper methods and javascript libraries to integrate maps in web applications."

  s.has_rdoc      = true
  s.rdoc_options  = ['--main', 'README.rdoc', '--charset=UTF-8']
  s.extra_rdoc_files = ['README.rdoc', 'LICENSE']

  s.files         = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.rdoc)
end
