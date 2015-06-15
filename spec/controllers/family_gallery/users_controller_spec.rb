require 'spec_helper'

describe FamilyGallery::UsersController do
  let(:admin) { create :admin }
  let(:valid_attributes) do
    {
      first_name: Forgery::Name.first_name,
      last_name: Forgery::Name.last_name,
      email: Forgery::Internet.email_address,
      password: Forgery::LoremIpsum.words(3, random: true)
    }
  end

  routes { FamilyGallery::Engine.routes }

  render_views

  before do
    sign_in admin
  end

  it '#index' do
    get :index
    expect(assigns(:users)).to eq [admin]
    expect(response).to be_success
  end

  it '#show' do
    get :show, id: admin.id
    expect(response).to be_success
  end

  it '#new' do
    get :new
    expect(response).to be_success
  end

  it '#create' do
    post :create, user: valid_attributes

    created_user = assigns(:user)

    expect(created_user).to be_valid
    expect(response).to redirect_to user_url(created_user)
  end

  it '#edit' do
    get :edit, id: admin.id
    expect(response).to be_success
  end

  it '#update' do
    patch :update, id: admin.id

    updated_user = assigns(:user)

    expect(updated_user).to be_valid
    expect(response).to redirect_to user_url(updated_user)
  end

  it '#destroy' do
    delete :destroy, id: admin.id

    expect { admin.reload }.to raise_error(ActiveRecord::RecordNotFound)
    expect(response).to redirect_to root_url
  end
end
