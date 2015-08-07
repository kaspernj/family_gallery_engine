require 'spec_helper'

describe FamilyGallery::PicturesController do
  let(:group) { create :group }
  let(:admin) { create :admin }
  let(:picture) { create :picture }

  routes { FamilyGallery::Engine.routes }

  render_views

  before do
    sign_in admin
  end

  it '#new' do
    get :new
    expect(response).to be_success
  end

  it 'new as mobile' do
    get :new, mobile: 1
    expect(response).to be_success
  end

  it '#show' do
    get :show, id: picture.id, group_id: group.id
    expect(response).to be_success
  end

  it 'show as mobile' do
    get :show, id: picture.id, group_id: group.id, mobile: 1
    expect(response).to be_success
  end

  it "#create" do
    post :create, picture: {title: "Test title", description: "Test test", image: fixture_file_upload(Rails.root.join('..', '..', 'spec', 'test_pictures', 'sigrid.jpg'), "image/jpeg")}, group_id: group.id
    last_picture = assigns(:picture)
    last_picture.errors.to_a.should eq []
    response.should redirect_to last_picture
    last_picture.width.should_not eq nil
    last_picture.groups.should eq [group]
    last_picture.user_uploaded.should eq admin
  end

  it '#edit' do
    get :edit, id: picture.id
    expect(response).to be_success
  end

  it 'edit as mobile' do
    get :edit, id: picture.id, mobile: 1
    expect(response).to be_success
  end

  it '#update' do
    patch :update, id: picture.id, picture: {title: 'Test'}
    expect(response).to redirect_to picture_url(picture)
  end

  it '#destroy' do
    delete :destroy, id: picture.id
    expect(response).to redirect_to root_url
  end
end
