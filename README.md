[![Code Climate](https://codeclimate.com/github/kaspernj/family_gallery/badges/gpa.svg)](https://codeclimate.com/github/kaspernj/family_gallery)
[![Test Coverage](https://codeclimate.com/github/kaspernj/family_gallery/badges/coverage.svg)](https://codeclimate.com/github/kaspernj/family_gallery)
[![Build Status](https://img.shields.io/shippable/54ed69135ab6cc13528db117.svg)](https://app.shippable.com/projects/54ed69135ab6cc13528db117/builds/latest)

# FamilyGallery

## Install

Add to your Gemfile and bundle:

```ruby
gem "family_gallery"
```

Then add something like this to your Rails-app's "routes.rb":
```ruby
mount FamilyGallery::Engine => "/family_gallery"
```

Create a config-file under "#{Rails.root}/config/family_gallery.yml" and insert this:
```yaml
facebook:
  app_id: 123
  app_secret: 321
```

In order to use the existing translations, you should add this line to your "application.rb":
```ruby
config.i18n.load_path += Dir[FamilyGallery::Engine.root.join("config", "locales", "**", "*.yml").to_s]
```

To create an admin-user with a password of "password", you can run the seed script like this:
```bash
bundle exec rake family_gallery:seed
```

You should now be able to access it on "http://localhost:3000/family_gallery".

## License

This project rocks and uses MIT-LICENSE.
