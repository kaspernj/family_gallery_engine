FactoryGirl.define do
  factory :user_tagging, class: "FamilyGallery::UserTagging" do
    position_top 10
    position_left 15

    association :user, factory: :user
    association :picture, factory: :picture
    association :tagged_by, factory: :user
  end
end
