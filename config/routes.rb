FamilyGallery::Engine.routes.draw do
  devise_for "family_gallery/users"

  resources :groups

  root "welcome#index"
end
