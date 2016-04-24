require 'tilt/template'
require 'ox/alt_builder'

module Tilt
  class OxAltBuilderTemplate < Template
    self.default_mime_type = 'text/xml'

    def self.engine_initialized?
      defined? ::Ox::AltBuilder
    end

    def initialize_engine
      require_template_library 'ox-alt-builder'
    end

    def prepare
      @code =<<-RUBY
        Ox::AltBuilder.build do
          #{data}
        end.to_xml
      RUBY
    end

    def precompiled_template(locals)
      @code
    end
  end
end
