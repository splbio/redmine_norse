Redmine::Plugin.register :redmine_norse do
  name 'Redmine Norse'
  author 'Eric Davis'
  description "Customizations to Redmine for Norse"
  version '1.0.0'
  author_url 'http://www.littlestreamsoftware.com'

  settings({
             :partial => 'settings/redmine_norse',
             :default => {
               'my_page_redirect' => nil
             }
           })
end

ActionDispatch::Callbacks.to_prepare do
  require_dependency 'my_controller'
end

MyController.send(:include, RedmineNorse::Patches::MyPageRedirect)
