$LOAD_PATH.push File.expand_path("../lib", __FILE__)

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
    path.start_with?("spec/dummy/public/system/**/*", "spec/test_files", "spec/dummy/tmp")
  end

  s.add_dependency "rails", ">= 4.2.0", "< 5.0.0"
  s.add_dependency "rails-i18n", "~> 4.0.4"
  s.add_dependency "haml-rails"
  s.add_dependency "plugin_migrator", "~> 0.0.3"
  s.add_dependency "devise", "3.5.6"
  s.add_dependency "globalize"
  s.add_dependency "sass-rails", "4.0.5"
  s.add_dependency "coffee-rails", "~> 4.1.1"
  s.add_dependency "jquery-rails", "~> 4.1.0"
  s.add_dependency "simple_form", "~> 3.2.1"
  s.add_dependency "simple_form_ransack", ">= 0.0.6"
  s.add_dependency "ransack"
  s.add_dependency "cancancan"
  s.add_dependency "omniauth"
  s.add_dependency "omniauth-facebook"
  s.add_dependency "paperclip", "4.3.5"
  s.add_dependency "exifr", "1.2.0"
  s.add_dependency "awesome_translations", "~> 0.0.25"
  s.add_dependency "will_paginate"
  s.add_dependency "rails_imager", ">= 0.0.30"
  s.add_dependency "rmagick", ">= 2.15.3"
  s.add_dependency "exception_notification", ">= 4.1.1"
  s.add_dependency "jquery-fileupload-rails"
  s.add_dependency "bootstrap_builders"
  s.add_dependency "twitter-bootstrap-rails", "3.2.2"

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
  # s.add_development_dependency "best_practice_project"
  s.add_development_dependency "rubocop", "0.36.0"
  # s.add_development_dependency "scss_lint", "0.43.2"
  s.add_development_dependency "coffeelint", "1.14.0"
  s.add_development_dependency "rails_best_practices"
  s.add_development_dependency "haml_lint", "0.16.0"
end
