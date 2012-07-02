ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'shoulda'
require 'mocha'

class MockMigratorator
  attr_accessor :tags, :id
  def initialize
    self.tags = %w[ a b c d section:directories e f ]
    self.id ="testo"
  end
end

class ActiveSupport::TestCase

  MigratoratorApi::Mapping.stubs(:find_by_id).returns(MockMigratorator.new)
  MigratoratorApi::Mapping.stubs(:find_random_mapping).returns(MockMigratorator.new)

  def login_as_stub_user
    @user = User.find_or_create_by(:name => 'Stub User', :email => "test@testing.com")
    request.env['warden'] = stub(:authenticate! => true, :authenticated? => true, :user => @user)
  end

end
