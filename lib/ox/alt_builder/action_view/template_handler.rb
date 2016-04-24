require 'active_support/core_ext/class/attribute'
require 'action_dispatch/http/mime_type'

module Ox
  module AltBuilder
    module ActionView
      class TemplateHandler
        class_attribute :default_format
        self.default_format = Mime::XML

        def call(template)
          <<-RUBY
            xml = ::Ox::AltBuilder.build {
              #{template.source}
            };xml.to_xml
          RUBY
        end
      end
    end
  end
end
