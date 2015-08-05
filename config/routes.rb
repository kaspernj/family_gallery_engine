FamilyGallery::Engine.routes.draw do
  mount AwesomeTranslations::Engine => '/awesome_translations' if Rails.env.development?

  devise_for "family_gallery/users"

  resources :groups do
    resources :pictures
    resources :multiple_pictures, only: [:new, :create]
    resources :jquery_file_upload_pictures
  end

  resources :locales, only: [:new, :create]

  resources :pictures do
    resources :user_taggings, only: [:new, :create, :destroy]
  end

  resources :users do
    resources :user_roles, only: [:new, :create, :destroy]
  end

  root "welcome#index"
end
