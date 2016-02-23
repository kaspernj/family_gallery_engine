require "family_gallery/engine"
require "awesome_translations"
require "devise"
require "haml-rails"
require "plugin_migrator"
require "globalize"
require "coffee-rails"
require "jquery-rails"
require "sass-rails"
require "cancancan"
require "omniauth"
require "omniauth-facebook"
require "ransack"
require "simple_form"
require "paperclip"
require "will_paginate"
require "rails-i18n"
require "rails_imager"
require "exception_notification"
require "simple_form_ransack"
require "jquery-fileupload-rails"
require "twitter-bootstrap-rails"
require "bootstrap_builders"

module FamilyGallery
  extend ActiveSupport::Autoload

  autoload :BaseFamilyGalleryController
end
