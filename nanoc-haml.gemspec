# encoding: utf-8

$LOAD_PATH.unshift(File.expand_path('../lib/', __FILE__))
require 'nanoc/haml/version'

Gem::Specification.new do |s|
  s.name        = 'nanoc-haml'
  s.version     = Nanoc::Haml::VERSION
  s.homepage    = 'http://nanoc.ws/'
  s.summary     = 'Haml support for nanoc'
  s.description = 'Provides a :haml filter for nanoc'

  s.author  = 'Denis Defreyne'
  s.email   = 'denis.defreyne@stoneship.org'
  s.license = 'MIT'

  s.required_ruby_version = '>= 1.9.3'

  s.files              = Dir['[A-Z]*'] +
                         Dir['{lib,test}/**/*'] +
                         [ 'nanoc-haml.gemspec' ]
  s.require_paths      = [ 'lib' ]

  s.rdoc_options     = [ '--main', 'README.md' ]
  s.extra_rdoc_files = [ 'LICENSE', 'README.md', 'NEWS.md' ]

  s.add_runtime_dependency('nanoc-core')
  s.add_runtime_dependency('haml')
  s.add_development_dependency('bundler')
end
