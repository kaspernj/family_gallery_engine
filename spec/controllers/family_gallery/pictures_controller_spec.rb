require 'spec_helper'

describe FamilyGallery::PicturesController do
  let(:group) { create :group }
  let(:admin) { create :admin }

  before do
    sign_in admin
  end

  it "#create" do
    post :create, use_route: :family_gallery, picture: {title: "Test title", description: "Test test", image: fixture_file_upload("#{Rails.root}/../../spec/test_pictures/sigrid.jpg", "image/jpeg")}, group_id: group.id
    last_picture = assigns(:picture)
    last_picture.errors.to_a.should eq []
    response.should redirect_to last_picture
    last_picture.width.should_not eq nil
    last_picture.groups.should eq [group]
    last_picture.user_uploaded.should eq admin
  end
end
