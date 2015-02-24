OmniAuth.config.logger = Rails.logger

config = YAML.load(File.read(File.join(Rails.root, "config", "family_gallery.yml")))

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, config["facebook"]["app_id"], config["facebook"]["app_secret"]
end
