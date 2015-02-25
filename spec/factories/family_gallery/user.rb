FactoryGirl.define do
  factory :user, class: "FamilyGallery::User" do
    email { Forgery::Internet.email_address }
    password { Forgery::LoremIpsum.words(2, random: true) }

    factory :admin do
      after :create do |user|
        user.user_roles.create(role: "administrator")
      end
    end
  end
end
