require 'spec_helper'

describe FamilyGallery::LocalesController do
  render_views

  routes { FamilyGallery::Engine.routes }

  it '#create' do
    post :create, locale: "da", format: :json

    expect(I18n.locale).to eq :da

    expect(response.body.to_s).to eq JSON.dump(success: true)
  end
end
