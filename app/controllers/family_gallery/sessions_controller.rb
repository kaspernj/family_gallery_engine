class FamilyGallery::SessionsController < Devise::SessionsController
  layout "family_gallery/application"
  helper FamilyGallery::ApplicationHelper

  include FamilyGallery::BaseFamilyGalleryController
end
