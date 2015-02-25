FactoryGirl.define do
  factory :group, class: "FamilyGallery::Group" do
    name { Forgery::LoremIpsum.words(2, random: true) }
    description { Forgery::LoremIpsum.words(10, random: true) }
  end
end
