# gem build *.gemspec
# gem push *.gem
#
require "./lib/hyde/version"
Gem::Specification.new do |s|
  s.name = "hydeweb"
  s.version = Hyde.version
  s.summary = "Website preprocessor."
  s.description = "Hyde lets you create static websites from a bunch of files written in HAML, Textile, Sass, or any other."
  s.authors = ["Rico Sta. Cruz"]
  s.email = ["rico@sinefunc.com"]
  s.homepage = "http://github.com/sinefunc/hyde"
  s.files = Dir["{bin,lib,test,data}/**/*", "*.md", "Rakefile", "AUTHORS"]
  s.executables = ["hyde", "hyde01"]

  s.add_dependency "shake", "~> 0.1"
  s.add_dependency "tilt", "~> 1.2.2"
  s.add_dependency "cuba", "~> 2.0.0"
  s.add_dependency "hashie", "~> 1.0.0"
  s.add_dependency "haml", "~> 3.1.1"
  s.add_dependency "sass", "~> 3.1.1"
  s.add_dependency "compass", "~> 0.11.1"
  s.add_dependency "RedCloth", "~> 4.2.3"
  s.add_dependency "maruku", "~> 0.6.0"

  s.add_development_dependency "less"
  s.add_development_dependency "maruku"
end
