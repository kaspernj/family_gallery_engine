require "family_gallery/engine"
require "awesome_translations"
require "devise"
require "haml-rails"
require "plugin_migrator"
require "globalize"
require "coffee-rails"
require "jquery-rails"
require "cancancan"
require "omniauth"
require "omniauth-facebook"
require "ransack"
require "simple_form"
require "paperclip"

module FamilyGallery
  extend ActiveSupport::Autoload

  autoload :BaseFamilyGalleryController
end
