require "spec_helper"

describe FamilyGallery::UserRolesController do
  let(:admin) { create :admin }
  let(:user) { create :user }
  let(:user_role) { create :user_role, user: user }
  let(:valid_params) do
    {
      role: "something"
    }
  end

  routes { FamilyGallery::Engine.routes }

  render_views

  before do
    sign_in admin
  end

  it '#new' do
    get :new, user_id: user.id
    expect(response).to be_success
  end

  it '#create' do
    post :create, user_id: user.id, user_role: valid_params
    expect(response).to redirect_to user
  end

  it '#destroy' do
    delete :destroy, user_id: user.id, id: user_role.id

    expect { user_role.reload }.to raise_error(ActiveRecord::RecordNotFound)
    expect(response).to redirect_to user
  end
end
