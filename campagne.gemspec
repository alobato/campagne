# -*- encoding: utf-8 -*-
require File.expand_path("../lib/campagne/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "campagne"
  s.version     = Campagne::VERSION
  s.authors     = ["Arley Lobato"]
  s.email       = ["arleylobato@gmail.com"]
  s.homepage    = "http://github.com/alobato/campagne"
  s.summary     = "campagne-#{s.version}"
  s.description = "A simple Rails 3 engine gem to manage and send newsletters."

  s.add_dependency "rails", "3.2.3"
  s.add_dependency "mysql2", "0.3.11"

  s.files = `git ls-files`.split("\n")
  s.executables = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'

end
