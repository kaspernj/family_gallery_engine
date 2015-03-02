require "spec_helper"

describe FamilyGallery::Picture do
  let(:picture) { create :picture }

  it "#parse_exif" do
    picture.should have_attached_file :image
    picture.taken_at.should eq Time.parse("2015-02-25 10:20:47 +0000")
    picture.latitude.should eq 54.7000236388889
    picture.longitude.should eq 11.3945503055556
    picture.width.should eq 4128
    picture.height.should eq 2322
  end
end
