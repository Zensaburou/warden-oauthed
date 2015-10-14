# -*- encoding: utf-8 -*-
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'warden-oauthed/version'

Gem::Specification.new do |s|
  s.name        = 'warden-oauthed'
  s.version     = Warden::Oauthed::VERSION
  s.authors     = ['David Jaress', 'Seth Herr']
  s.homepage    = 'https://github.com/Zensaburou/warden-oauthed'
  s.license     = 'MIT'
  s.summary     = 'A warden strategy for easy OAuth2 rack based
                   authentication'
  s.description = s.summary

  s.add_dependency 'json', '~>1.5'
  s.add_dependency 'multi_json', '~> 1.11', '>= 1.11.2'
  s.add_dependency 'warden', '~>1.0'
  s.add_dependency 'oauth2', '~>0.5', '>=0.5.2'

  s.add_development_dependency 'rack', '~> 1.6', '>=1.6.0'
  s.add_development_dependency 'rake', '~> 10.4', '>=10.4.2'
  s.add_development_dependency 'rerun', '~> 0.11', '>=0.11.0'
  s.add_development_dependency 'rspec', '~> 2.8', '>=2.8.0'
  s.add_development_dependency 'webrat', '~> 0.7', '>=0.7.3'
  s.add_development_dependency 'sinatra', '~> 1.4', '>=1.4.6'
  s.add_development_dependency 'shotgun', '~> 0.9', '>=0.9.1'
  s.add_development_dependency 'addressable', '~> 2.2', '>=2.2.0'
  s.add_development_dependency 'rack-test', '~> 0.5', '>=0.5.3'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n")
    .map { |f| File.basename(f) }
  s.require_paths = ['lib']
end
