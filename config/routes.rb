FamilyGallery::Engine.routes.draw do
  devise_for "family_gallery/users"

  resources :groups
  resources :pictures

  root "welcome#index"
end
