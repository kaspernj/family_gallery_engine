class FamilyGallery::SessionsController < Devise::SessionsController
  layout "family_gallery/application"
  include FamilyGallery::BaseFamilyGalleryController
end
