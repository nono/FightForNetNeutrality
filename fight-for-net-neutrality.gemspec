Gem::Specification.new do |s|
  s.name             = "fight-for-net-neutrality"
  s.version          = "0.1.0"
  s.date             = Time.now.utc.strftime("%Y-%m-%d")
  s.homepage         = "http://github.com/nono/FightForNetNeutrality"
  s.authors          = "Bruno Michel"
  s.email            = "bruno.michel@af83.com"
  s.description      = "This package is a Rack middleware which allow to block some IP Address. By default the french parlement is denied."
  s.summary          = s.description
  s.extra_rdoc_files = %w(README.md)
  s.files            = Dir["MIT-LICENSE", "README.md", "Gemfile", "lib/*.rb"]
  s.require_paths    = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.add_dependency "rack", "~>1.2"
  s.add_development_dependency "minitest", "~>2.0"
end
