$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "family_gallery/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "family_gallery"
  s.version     = FamilyGallery::VERSION
  s.authors     = ["Kasper Johansen"]
  s.email       = ["k@spernj.org"]
  s.homepage    = "https://www.github.com/kaspernj/family_gallery"
  s.summary     = "A picture gallery supporting tagging, groups and much more."
  s.description = "A picture gallery supporting tagging, groups and much more."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.0.10"
  s.add_dependency "haml-rails"
  s.add_dependency "plugin_migrator"
  s.add_dependency "devise"
  s.add_dependency "globalize"
  s.add_dependency "sass-rails"
  s.add_dependency "coffee-rails"
  s.add_dependency "jquery-rails"
  s.add_dependency "simple_form"
  s.add_dependency "simple_form_ransack", ">= 0.0.6"
  s.add_dependency "ransack"
  s.add_dependency "cancancan"
  s.add_dependency "omniauth"
  s.add_dependency "omniauth-facebook"
  s.add_dependency "paperclip"
  s.add_dependency "exifr", "1.2.0"
  s.add_dependency "awesome_translations"

  s.add_development_dependency "mysql2"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "forgery"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "codeclimate-test-reporter"
  s.add_development_dependency "pry"

  # Deploy
  s.add_development_dependency "capistrano"
  s.add_development_dependency "capistrano-rails"
  s.add_development_dependency "capistrano-bundler"
end
