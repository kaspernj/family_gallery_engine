FamilyGallery::Engine.routes.draw do
  mount AwesomeTranslations::Engine => "/awesome_translations" if Rails.env.development?

  devise_for "family_gallery/users"

  resources :groups do
    resources :pictures
  end

  resources :locales, only: :create

  resources :pictures do
    resources :user_taggings
  end

  resources :users

  root "welcome#index"
end
