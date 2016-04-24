require 'ox'
require 'docile'
require 'ox/alt_builder/version'
require 'ox/alt_builder/dsl'
require 'ox/alt_builder/factory'
require 'ox/alt_builder/fallback_context_proxy'

module Ox
  module AltBuilder
    class << self
      def build(node = Ox::Document.new, &block)
        Factory.new(node).tap do |builder|
          dsl_eval(builder, builder, &block) if block_given?
        end
      end

    private

      def dsl_eval(dsl, *args, &block)
        Docile::Execution.exec_in_proxy_context(dsl, FallbackContextProxy, *args, &block)
      end
    end
  end
end

if defined?(Tilt)
  require 'tilt/ox_alt_builder_template'
  Tilt.register Tilt::OxAltBuilderTemplate, 'ox'
end

if defined?(ActionView)
  require 'ox/alt_builder/action_view/template_handler'
  ActionView::Template.register_template_handler :ox, Ox::AltBuilder::ActionView::TemplateHandler.new
end
