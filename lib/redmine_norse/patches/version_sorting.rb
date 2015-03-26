module RedmineNorse
  module Patches
    # Sort versions by id, overriding the regular Redmine sorting
    # of: date/name, name
    #
    module VersionSorting
      extend ActiveSupport::Concern

      included do
        unloadable

        scope :sorted, lambda { order(:id) }

        def <=>(version)
          self.id <=> version.id
        end
      end

      module ClassMethods
      end
    end
  end
end
