FactoryGirl.define do
  factory :picture, class: "FamilyGallery::Picture" do
    title { Forgery::Name.first_name }
    description { Forgery::LoremIpsum.words(10, random: true) }
    image { File.new("#{Rails.root}/../../spec/test_pictures/sigrid.jpg") }

    association :user_owner, factory: :user
    association :user_uploaded, factory: :user

    after :create do |picture|
      picture.reload
    end
  end
end
