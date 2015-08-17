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
  s.test_files = Dir["spec/**/*"].reject do |path|
    path.start_with?("spec/dummy/public/system/**/*") ||
    path.start_with?("spec/test_files") ||
    path.start_with?("spec/dummy/tmp")
  end

  s.add_dependency "rails", ">= 4.2.0", "< 5.0.0"
  s.add_dependency "rails-i18n", "~> 4.0.4"
  s.add_dependency "haml-rails"
  s.add_dependency "plugin_migrator", '~> 0.0.3'
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
  s.add_dependency "paperclip", "4.3.0"
  s.add_dependency "exifr", "1.2.0"
  s.add_dependency "awesome_translations", "~> 0.0.24"
  s.add_dependency "will_paginate"
  s.add_dependency "light_mobile", ">= 0.0.11"
  s.add_dependency "rails_imager", ">= 0.0.29"
  s.add_dependency "rmagick", ">= 2.15.3"
  s.add_dependency "exception_notification", ">= 4.1.1"

  if RUBY_ENGINE == "jruby"
    s.add_development_dependency "activerecord-jdbc-adapter"
    s.add_development_dependency "jdbc-mysql"
  else
    s.add_development_dependency "mysql2"
  end

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
