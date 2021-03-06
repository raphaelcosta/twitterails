# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
require 'webmock/rspec'

# Coverage
require 'simplecov'
SimpleCov.start

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include Rails.application.routes.url_helpers
  config.include Features::SessionHelpers, type: :feature

  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
end
