ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'capybara/rails'
require 'rspec/rails'
# require 'webmock/rspec'
Capybara.ignore_hidden_elements = false

Dir[File.expand_path("app/controllers/admin/\*.rb")].each do |file|
  require file
end

Dir[File.expand_path("app/controllers/user/\*.rb")].each do |file|
  require file
end

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.mock_with :mocha
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    begin
      DatabaseCleaner.start
      # Test factories in spec/factories are working.
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end

  # config.before(:each) do
  #   Home.any_instance.stubs(:geocode).returns([1,1])
  #   WebMock.stub_request(:get, "http://maps.googleapis.com/maps/api/geocode/json?address=MyString&language=en&sensor=false").
  #     with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
  #     to_return(:status => 200, :body => File.read(File.join("spec", "support", "geocoder", "data.json")), :headers => {})
  # end
end
