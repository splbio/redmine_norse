module RedmineNorse
  module Patches
    module MyPageRedirect
      extend ActiveSupport::Concern

      included do
        unloadable

        before_filter :redirect_my_page_if_redirect_configured
      end

      # If the my_page_redirect setting is configured, redirect all users
      # there instead of My Page
      #
      def redirect_my_page_if_redirect_configured
        redirect_url = Setting.plugin_redmine_norse["my_page_redirect"]

        if redirect_url.present?
          redirect_to redirect_url.strip
        else
          return true
        end
      end

      module ClassMethods
      end
    end
  end
end
