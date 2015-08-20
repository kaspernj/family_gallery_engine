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
require "will_paginate"
require "light_mobile"
require "rails-i18n"
require "rails_imager"
require "exception_notification"
require "simple_form_ransack"
require "jquery-fileupload-rails"

module FamilyGallery
  extend ActiveSupport::Autoload

  autoload :BaseFamilyGalleryController
end
