Dummy::Application.routes.draw do
  mount FamilyGallery::Engine, at: "/family_gallery"

  root to: redirect("/family_gallery")
end
