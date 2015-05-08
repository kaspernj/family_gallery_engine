require 'spec_helper'

describe FamilyGallery::GroupsController do
  let(:group) { create :group, user_owner: user }
  let(:user) { create :user }
  let(:valid_params) do
    {
      name: Forgery::LoremIpsum.words(2)
    }
  end

  render_views

  routes { FamilyGallery::Engine.routes }

  before do
    sign_in user
  end

  it '#index' do
    group
    get :index
    expect(assigns(:groups)).to eq [group]
  end

  it '#show' do
    get :show, id: group.id
    expect(response).to be_success
  end

  it '#new' do
    get :new
    expect(response).to be_success
  end

  it '#create' do
    post :create, group: valid_params

    created_group = assigns(:group)
    expect(created_group).to be_valid

    expect(response).to redirect_to created_group
  end

  it '#edit' do
    get :edit, id: group.id
    expect(response).to be_success
  end

  it '#update' do
    put :update, id: group.id, group: valid_params

    updated_group = assigns(:group)
    expect(updated_group).to be_valid

    expect(response).to redirect_to updated_group
  end

  it '#destroy' do
    delete :destroy, id: group.id

    expect { group.reload }.to raise_error(ActiveRecord::RecordNotFound)

    expect(response).to redirect_to groups_url
  end
end