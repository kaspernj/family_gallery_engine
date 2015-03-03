namespace :family_gallery do
  task "seed" => :environment do
    puts "Creating user: admin@example.com"
    admin_user = FamilyGallery::User.find_or_initialize_by(email: "admin@example.com")
    admin_user.assign_attributes(
      first_name: "Admin",
      last_name: "User",
      password: "password"
    )
    admin_user.save!

    admin_role = admin_user.user_roles.find_or_initialize_by(role: "administrator").save!
  end
end
