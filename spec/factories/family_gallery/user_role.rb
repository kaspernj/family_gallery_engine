FactoryGirl.define do
  factory :user_role, class: "FamilyGallery::UserRole" do
    association :user, factory: :user

    role "administrator"
  end
end
