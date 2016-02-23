require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

ENV["RAILS_ENV"] ||= "test"
require "dummy/config/environment"
require "rspec/rails"
require "forgery"
require "factory_girl_rails"
require "paperclip/matchers"

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.include ActionDispatch::TestProcess
  config.include FactoryGirl::Syntax::Methods
  config.include Paperclip::Shoulda::Matchers

  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end

  config.after(:all) do
    FileUtils.rm_rf(Dir["#{Rails.root}/spec/test_files/0"]) if Rails.env.test?
  end

  config.include Devise::TestHelpers, type: :controller
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
end
