require File.dirname(__FILE__) + '/../../../../test_helper'

class RedmineNorse::Patches::MyPageRedirectTest < Redmine::IntegrationTest
  fixtures :users, :email_addresses, :roles

  context "without My Page redirect setup" do
    setup do
      Setting.plugin_redmine_norse = {'my_page_redirect' => " "}
    end

    should "work like normal" do
      get "/"
      log_user 'jsmith', 'jsmith'

      get "/my/page"
      assert_response :success
      assert_template "my/page"
    end
  end

  context "with My Page redirect setup" do
    setup do
      Setting.plugin_redmine_norse = {'my_page_redirect' => "/issues?custom_params=1"}
    end

    should "redirect to the configured url" do
      get "/"
      log_user 'jsmith', 'jsmith'

      get "/my/page"
      assert_response :redirect
      assert_redirected_to "/issues?custom_params=1"
    end
  end

end
