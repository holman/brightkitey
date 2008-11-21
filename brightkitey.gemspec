Gem::Specification.new do |s|
  s.name = %q{brightkitey}
  s.version = "0.1.0"
 
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Zach Holman"]
  s.date = %q{2008-11-20}
  s.description = %q{A cute little Ruby wrapper around Brightkite's API}
  s.email = [""]
  s.files = ["README.markdown", "lib/brightkitey.rb"]
  s.has_rdoc = false
  s.homepage = %q{http://github.com/holman/brightkitey}
  s.rdoc_options = ["--main", "README.markdown"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{A cute little Ruby wrapper around Brightkite's API}
  s.test_files = []
 
  s.add_dependency(%q<activeresource>, [">= 2.1.0"])  
end