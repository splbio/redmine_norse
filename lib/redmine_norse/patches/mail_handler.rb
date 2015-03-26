module RedmineNorse
  module Patches
    module MailHandler
      extend ActiveSupport::Concern

      included do
        unloadable

        alias_method_chain :plain_text_body, :anonymous_details
      end

      # Include the sender's name and email in the issue description
      # when anonymous emails are sent to the specific email address
      #
      def plain_text_body_with_anonymous_details
        plain_text_body = plain_text_body_without_anonymous_details
        if @user.anonymous?
          plain_text_body = "From: #{email.header['from'].to_s}\n\n" + plain_text_body
        end
        plain_text_body
      end

      module ClassMethods
      end
    end
  end
end
