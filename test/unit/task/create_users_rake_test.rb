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
      @task_name = "db:create_users"
      @file_name = Rails.root.join("test/fixtures/test_users_to_create.txt").to_s
      @test_user = User.create!(:name => 'Stub User 2', :email => "stub2@digital.cabinet-office.gov.uk")
    end

    should "read emails addresses in from the file passed as a parameter" do
      User.expects(:create!).with(has_entry(:email => "test.user@digital.cabinet-office.gov.uk")).returns(@test_user)
      @test_user.stubs(:send_reset_password_instructions)
      @rake[@task_name].invoke(@file_name)
    end

    should "create a user and then send reset password instructions where a user does not exist" do
      User.expects(:create!).with(has_entry(:email => "test.user@digital.cabinet-office.gov.uk")).returns(@test_user)
      @test_user.expects(:send_reset_password_instructions)
      @rake[@task_name].invoke(@file_name)
    end

    should "find the user and then send reset password instructions where a user already exists" do
      existing_user = User.create!(:email => "test.user@digital.cabinet-office.gov.uk", :name => "Test User")
      User.expects(:first).returns(existing_user)
      existing_user.expects(:send_reset_password_instructions)
      @rake[@task_name].invoke(@file_name)
    end

    should "set the name to the first part of the email if the email is foo.bar@baz format" do
      File.stubs(:readlines).returns( ["Testing.email@email.com"] )
      User.expects(:create!).with(has_entry(:name => "Testing")).returns(@test_user)
      @test_user.stubs(:send_reset_password_instructions)
      @rake[@task_name].invoke(@file_name)
    end
  

    should "capitalise the name if it is parsed from the email address" do
      File.stubs(:readlines).returns( ["testing.email@email.com"] )
      User.expects(:create!).with(has_entry(:name => "Testing")).returns(@test_user)
      @test_user.stubs(:send_reset_password_instructions)
      @rake[@task_name].invoke(@file_name)
    end

    should "set the name to the full email is the email is not in the format foo.bar@baz" do
      File.stubs(:readlines).returns( ["testing@email.com"] )
      User.expects(:create!).with(has_entry(:name => "testing@email.com")).returns(@test_user)
      @test_user.stubs(:send_reset_password_instructions)
      @rake[@task_name].invoke(@file_name)
    end

    should "recognise that a user already exists even if their email address is in a different case" do
      existing_user = User.create!(:email => "testuser.lowercase@digital.cabinet-office.gov.uk", :name => "Test User")
      File.stubs(:readlines).returns( ["Testuser.Lowercase@digital.cabinet-office.gov.uk"] )
            

      User.expects(:first).returns(existing_user)
      existing_user.expects(:send_reset_password_instructions)
      @rake[@task_name].invoke(@file_name)
    end
  
  end


end