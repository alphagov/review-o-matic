require_relative '../../test_helper'
require 'rake'

class CreateUsersRakeTest < ActiveSupport::TestCase

  setup do
    @rake = Rake::Application.new
    Rake.application = @rake
    Rake.application.rake_require("lib/tasks/create_users", [Rails.root.to_s], [])
    Rake::Task.define_task(:environment)
  end

  context "db:create_users" do
    setup do
      @test_user = User.create!(:name => 'Stub User 2', :email => "stub2@digital.cabinet-office.gov.uk")

      @task_name = "db:create_users"
      @file_name = Rails.root.join("test/fixtures/test_users_to_create.txt").to_s

      User.stubs(:first).returns(@test_user)
      User.stubs(:send_reset_password_instructions)
    end

    should "call User.where" do
      User.stubs(:create!).returns(@test_user)
      User.expects(:create!).returns(@test_user)
      @rake[@task_name].invoke(@file_name)
    end

  end


end