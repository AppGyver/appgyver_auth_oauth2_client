# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "appgyver_auth/version"

Gem::Specification.new do |s|
  s.name        = "appgyver_auth"
  s.version     = AppgyverAuth::VERSION
  s.authors     = ["Juha Suuraho", "Jesse Ikonen"]
  s.email       = ["juha@enemy.fi"]
  s.homepage    = ""
  s.summary     = "AppGyver Auth gem"
  s.description = "AppGyver Auth gem"

  s.rubyforge_project = "appgyver_auth"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "omniauth", ['~> 1.9.1', '< 2']
  s.add_dependency "omniauth-oauth2"

  s.add_development_dependency "rake"
  # s.add_development_dependency "rails"
end
