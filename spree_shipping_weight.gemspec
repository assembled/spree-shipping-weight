# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "spree_shipping_weight"
  s.version = "0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Assembled Goods"]
  s.date = "2013-03-25"
  s.email = ""
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")
  s.requirements = ["none"]
  s.rubygems_version = "2.0.3"
  s.summary = "Spree shipping costs calculator based on weight"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<spree_core>, [">= 1.0.0"])
      s.add_development_dependency(%q<capybara>, ["= 1.0.1"])
      s.add_development_dependency(%q<factory_girl>, [">= 0"])
      s.add_development_dependency(%q<ffaker>, [">= 0"])
      s.add_development_dependency(%q<rspec-rails>, ["~> 2.7"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
    else
      s.add_dependency(%q<spree_core>, [">= 1.0.0"])
      s.add_dependency(%q<capybara>, ["= 1.0.1"])
      s.add_dependency(%q<factory_girl>, [">= 0"])
      s.add_dependency(%q<ffaker>, [">= 0"])
      s.add_dependency(%q<rspec-rails>, ["~> 2.7"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
    end
  else
    s.add_dependency(%q<spree_core>, [">= 1.0.0"])
    s.add_dependency(%q<capybara>, ["= 1.0.1"])
    s.add_dependency(%q<factory_girl>, [">= 0"])
    s.add_dependency(%q<ffaker>, [">= 0"])
    s.add_dependency(%q<rspec-rails>, ["~> 2.7"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
  end
end
