# gem build *.gemspec
# gem push *.gem
#
require "./lib/hyde"
Gem::Specification.new do |s|
  s.name = "hydeweb"
  s.version = Hyde.version
  s.summary = "Website preprocessor."
  s.description = "Hyde lets you create static websites from a bunch of files written in HAML, Textile, Sass, or any other."
  s.authors = ["Rico Sta. Cruz"]
  s.email = ["rico@sinefunc.com"]
  s.homepage = "http://github.com/sinefunc/hyde"
  s.files = <%= Dir["{bin,lib,test,data}/**/*", "*.md", "Rakefile", "AUTHORS"].inspect %>
  s.executables = ["hyde", "hyde01"]

  s.add_dependency "shake", "~> 0.1"
  s.add_dependency "tilt", ">= 1.2.2"
  s.add_dependency "cuba", ">= 1.0.0"

  s.add_development_dependency "haml"
  s.add_development_dependency "less"
  s.add_development_dependency "maruku"
end
