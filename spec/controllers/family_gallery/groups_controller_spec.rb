require "spec_helper"

describe FamilyGallery::GroupsController do
  let(:group) { create :group, user_owner: user }
  let(:picture_1) { create :picture, groups: [group], taken_at: "1985-06-17 10:30" }
  let(:picture_2) { create :picture, groups: [group], taken_at: "1985-06-18 9:00" }
  let(:user) { create :admin }
  let(:group_name) { Forgery::LoremIpsum.words(2) }
  let(:group_description) { Forgery::LoremIpsum.words(255) }
  let(:valid_params) do
    {
      name: group_name,
      description: group_description,
      date_from: "1985/06/17 10:30",
      date_to: "1985/06/18 9:00"
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
    expect(created_group.name).to eq group_name
    expect(created_group.description).to eq group_description
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
    expect(updated_group.name).to eq group_name
    expect(updated_group.description).to eq group_description
  end

  it '#destroy' do
    delete :destroy, id: group.id

    expect { group.reload }.to raise_error(ActiveRecord::RecordNotFound)
    expect(response).to redirect_to groups_url
  end

  it '#set_dates_from_pictures' do
    picture_1
    picture_2

    post :set_dates_from_pictures, id: group.id
    group.reload

    expect(group.date_from).to eq Time.zone.parse("1985-06-17 10:30")
    expect(group.date_to).to eq Time.zone.parse("1985-06-18 9:00")
    expect(response).to redirect_to group
  end
end
