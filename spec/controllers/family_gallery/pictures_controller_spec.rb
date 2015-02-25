require "spec_helper"

describe FamilyGallery::PicturesController do
  let(:group) { create :group }
  let(:admin) { create :admin }

  before do
    sign_in admin
  end

  it "#create" do
    post :create, use_route: :family_gallery, picture: {title: "Test title", description: "Test test"}, group_id: group.id
    last_picture = FamilyGallery::Picture.last
    assigns(:picture).errors.to_a.should eq []
    response.should redirect_to last_picture
    last_picture.groups.should eq [group]
  end
end
