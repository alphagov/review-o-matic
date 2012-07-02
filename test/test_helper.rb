ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'shoulda'
require 'mocha'

class MockMigratorator
  attr_accessor :tags
  def initialize
    self.tags = %w[ a b c d section:directories e f ]
  end
end

class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...

  MigratoratorApi::Mapping.stubs(:find_by_id).returns(MockMigratorator.new)

end
