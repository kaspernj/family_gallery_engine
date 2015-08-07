require 'spec_helper'

describe FamilyGallery::UsersController do
  let(:admin) { create :admin }
  let(:user) { create :user }
  let(:valid_params) do
    {
      first_name: Forgery::Name.first_name,
      last_name: Forgery::Name.last_name,
      email: Forgery::Internet.email_address
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
    get :show, id: user.id
    expect(response).to be_success
  end

  it 'show as mobile' do
    get :show, id: user.id, mobile: 1
    expect(response).to be_success
  end

  it '#new' do
    get :new
    expect(response).to be_success
  end

  it 'new as mobile' do
    get :new, mobile: 1
    expect(response).to be_success
  end

  it '#create' do
    post :create, user: valid_params

    created_user = assigns(:user)

    expect(created_user).to be_valid
    expect(response).to redirect_to user_url(created_user)
  end

  it '#edit' do
    get :edit, id: user.id
    expect(response).to be_success
  end

  it 'edit as mobile' do
    get :edit, id: user.id, mobile: 1
    expect(response).to be_success
  end

  it '#update' do
    patch :update, id: user.id, user: valid_params

    user_updated = assigns(:user)
    expect(user_updated).to be_valid

    expect(response).to redirect_to user_url(user)
  end

  it '#destroy' do
    delete :destroy, id: user.id

    expect { user.reload }.to raise_error(ActiveRecord::RecordNotFound)
    expect(response).to redirect_to users_url
  end
end
