require "spec_helper"

describe FamilyGallery::PicturesController do
  let(:group) { create :group }
  let(:admin) { create :admin }
  let(:picture) { create :picture }
  let(:valid_params) do
    {
      title: "Test title",
      description: "Test test",
      taken_at: "1985/06/17 10:30",
      image: fixture_file_upload(Rails.root.join("..", "..", "spec", "test_pictures", "sigrid.jpg"), "image/jpeg")
    }
  end

  routes { FamilyGallery::Engine.routes }

  render_views

  before do
    sign_in admin
  end

  it '#new' do
    get :new
    expect(response).to be_success
  end

  it '#show' do
    get :show, id: picture.id, group_id: group.id
    expect(response).to be_success
  end

  it "#create" do
    post :create, picture: valid_params, group_id: group.id
    created_picture = assigns(:picture)
    created_picture.reload
    created_picture.errors.to_a.should eq []
    response.should redirect_to created_picture
    created_picture.groups.should eq [group]
    created_picture.user_uploaded.should eq admin
    expect(created_picture.taken_at).to eq Time.zone.parse("1985-06-17 10:30")
    expect(created_picture.image_to_show_file_name).to_not eq nil
    created_picture.width.should_not eq nil
  end

  it '#edit' do
    get :edit, id: picture.id
    expect(response).to be_success
  end

  it '#update' do
    patch :update, id: picture.id, picture: {title: "Test"}
    expect(response).to redirect_to picture_url(picture)
  end

  it '#destroy' do
    delete :destroy, id: picture.id
    expect(response).to redirect_to root_url
  end

  it "#rotate" do
    picture.groups << group
    request.env["HTTP_REFERER"] = group_picture_path(picture.groups.first, picture)
    post :rotate, id: picture.id, degrees: 90
    expect(response).to redirect_to [group, picture]
  end
end
