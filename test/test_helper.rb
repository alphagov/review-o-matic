ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)

require 'rails/test_help'
require 'shoulda'
require 'mocha'
require 'database_cleaner'
require 'webmock/test_unit'

WebMock.disable_net_connect!(:allow_localhost => true)

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

class MockMigratorator
  attr_accessor :tags, :id, :title, :old_url, :new_url, :status
  def initialize
    self.tags = %w[ a b c d section:directories e f ]
    self.id ="testo"
    self.title = "testo"
    self.old_url = "old_url"
    self.new_url = "new_url"
    self.status = "positive"
  end
end

class ActiveSupport::TestCase

  # MigratoratorApi::Mapping.stubs(:find_by_id).returns(MockMigratorator.new)
  # MigratoratorApi::Mapping.stubs(:find_random_mapping).returns(MockMigratorator.new)

  MIGRATORATOR_ENDPOINT = 'http://migratorator.test.gov.uk'

  def migratorator_has_mapping(mapping)
    url = "#{MIGRATORATOR_ENDPOINT}/api/mappings/#{mapping['id']}.json"
    stub_request(:get, url).to_return(:status => 200, :body => { "mapping" => mapping }.to_json, :headers => {})
  end

  def migratorator_has_random_mapping(mapping)
    url = "#{MIGRATORATOR_ENDPOINT}/api/mappings/random.json"
    stub_request(:get, url).to_return(:status => 200, :body => { "mapping" => mapping }.to_json, :headers => {})
  end

  def migratorator_has_tags(tags)
    url = "#{MIGRATORATOR_ENDPOINT}/api/mappings/random.json"
    stub_request(:get, url).to_return(:status => 200, :body => { "tags" => tags }.to_json, :headers => {})
  end

  def login_as_nongds_stub_user
    @user = User.find_or_create_by(:name => 'Stub User', :email => "test@testing.com")
    request.env['warden'] = stub(:authenticate => @user, :authenticate! => true, :authenticated? => true, :user => @user)
  end

  def login_as_gds_stub_user
    @user = User.find_or_create_by(:name => 'Stub User 2', :email => "stub2@digital.cabinet-office.gov.uk")
    request.env['warden'] = stub(:authenticate => @user, :authenticate! => true, :authenticated? => true, :user => @user)
  end

  teardown do
    WebMock.reset!
    DatabaseCleaner.clean
  end

end

class ActionController::TestCase
  include Devise::TestHelpers
end
