# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "pg_schema/version"

Gem::Specification.new do |s|
  s.name        = "pg_schema"
  s.version     = PgSchema::VERSION
  s.authors     = ["Alex Skryl"]
  s.email       = ["rut216@gmail.com"]
  s.homepage    = "http://skryl.org"
  s.summary     = %q{Postgres schema support}
  s.description = %q{Support for postgres schema}

  s.rubyforge_project = "pg_schema"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"

end
