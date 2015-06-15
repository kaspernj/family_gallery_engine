require 'spec_helper'

describe FamilyGallery::UserTaggingsController do
  let(:user) { create :user }
  let(:picture) { create :picture, user_owner: user }
  let(:user_tagging) { create :user_tagging, picture: picture, user: user }
  let(:valid_params) do
    {
      user_id: user.id,
      position_top: 10,
      position_left: 15
    }
  end

  render_views

  routes { FamilyGallery::Engine.routes }

  before do
    sign_in user
  end

  it '#create' do
    post :create, picture_id: picture.id, user_tagging: valid_params

    created_tagging = assigns(:user_tagging)
    expect(created_tagging).to be_valid

    expect(response).to redirect_to picture
  end

  it '#destroy' do
    delete :destroy, picture_id: picture.id, id: user_tagging.id

    expect { user_tagging.reload }.to raise_error(ActiveRecord::RecordNotFound)

    expect(response).to redirect_to picture
  end
end
