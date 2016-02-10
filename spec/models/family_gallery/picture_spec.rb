require "spec_helper"

describe FamilyGallery::Picture do
  let(:picture) { create :picture }

  it "#parse_exif" do
    picture.should have_attached_file :image
    picture.taken_at.should eq Time.zone.parse("2015-02-25 10:20:47 +0000")
    picture.latitude.to_f.round(5).should eq 54.70002
    picture.longitude.to_f.round(5).should eq 11.39455
    picture.width.should eq 4128
    picture.height.should eq 2322
  end
end
