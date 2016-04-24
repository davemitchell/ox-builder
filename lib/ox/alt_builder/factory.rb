module Ox
  module AltBuilder
    class Factory
      include DSL

      attr_reader :node

      def initialize(node)
        @node = node
      end

      def to_s(options = {})
        encoding = options.fetch(:encoding, 'UTF-8')
        indent = options.fetch(:indent, 2)
        Ox.dump(node, encoding: encoding, indent: indent)
      end
      alias_method :to_xml, :to_s

      def inspect
        "#<#{self.class.name}:0x#{"%x" % object_id} node=#{node}>"
      end

      def add_attributes(attributes)
        attributes.each do |key, val|
          node[key] = val
        end
      end

    protected

      def method_missing(name, *args, &block)
        name = name[0...-1] if name.to_s.end_with?('!')
        tag!(name, *args, &block)
      end

      def with_dsl(obj, &block)
        Factory.new(obj).tap(&block)
      end
    end
  end
end
