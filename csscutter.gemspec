require 'date'
require './lib/csscutter/version'

Gem::Specification.new do |s|
  s.name        = 'csscutter'
  s.version     = CssCutter::VERSION
  s.date        = Date.today.to_s
  s.summary     = 'CSS minifier'
  s.description = 'CSS minifier inspired by cssmin'
  s.authors     = ['m16a1']
  s.email       = 'a741su@gmail.com'
  s.files       = Dir['lib/**/*', 'License']
  s.homepage    = 'https://github.com/m16a1/csscutter'
end