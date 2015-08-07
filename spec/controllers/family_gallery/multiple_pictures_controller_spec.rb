require 'spec_helper'

describe FamilyGallery::MultiplePicturesController do
  let(:group) { create :group }
  let(:admin) { create :admin }

  routes { FamilyGallery::Engine.routes }

  render_views

  before do
    sign_in admin
  end

  it '#new' do
    get :new, group_id: group.id
    expect(response).to be_success
  end

  it 'new as mobile' do
    get :new, group_id: group.id, mobile: 1
    expect(response).to be_success
  end

  it '#create' do
    post :create, group_id: group.id, multiple_pictures: {files: [
      fixture_file_upload(Rails.root.join('..', '..', 'spec', 'test_pictures', 'sigrid.jpg'), "image/jpeg"),
      fixture_file_upload(Rails.root.join('..', '..', 'spec', 'test_pictures', 'sigrid.jpg'), "image/jpeg"),
      fixture_file_upload(Rails.root.join('..', '..', 'spec', 'test_pictures', 'sigrid.jpg'), "image/jpeg")
    ]}

    expect(response).to redirect_to group_url(group)
  end
end
