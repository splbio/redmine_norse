require File.dirname(__FILE__) + '/../../../../test_helper'

class RedmineNorse::Patches::MailHandlerTest < Redmine::IntegrationTest
  fixtures :users, :projects, :enabled_modules, :roles,
           :members, :member_roles, :users,
           :email_addresses,
           :issues, :issue_statuses,
           :workflows, :trackers, :projects_trackers,
           :versions, :enumerations, :issue_categories,
           :custom_fields, :custom_fields_trackers, :custom_fields_projects,
           :boards, :messages

  FIXTURES_PATH = File.dirname(__FILE__) + '/../../../../../../../test/fixtures/mail_handler'

  context "#plain_text_body with a regular user" do
    should "not prefix the body with the sender" do
      issue = submit_email('ticket_on_given_project.eml',
                           :issue => {:project => 'onlinestore'})

      refute_match /JSmith@somenet.foo/i, issue.description
    end
  end

  context "#plain_text_body with an Anonymous user" do
    should "prefix the body with the sender so it can be tracked" do
      # Anonymous user, private project, without permission check
      issue = submit_email(
                           'ticket_by_unknown_user.eml',
                           :issue => {:project => 'onlinestore'},
                           :no_permission_check => '1',
                           :unknown_user => 'accept'
                           )

      assert_match /From: John Doe <john.doe@somenet.foo>/i, issue.description
    end
  end

  # From test/unit/mail_handler_test.rb
  def submit_email(filename, options={})
    raw = IO.read(File.join(FIXTURES_PATH, filename))
    yield raw if block_given?
    MailHandler.receive(raw, options)
  end

end
