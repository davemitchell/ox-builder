$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

# Load action view so that we can test the template handler
require 'active_support'
require 'active_support/hash_with_indifferent_access'
require 'action_view'
require 'tilt'

require 'ox/alt_builder'

def load_xml(filename)
  File.read("spec/support/#{filename}.out.xml")
end

def generate(options = {}, &block)
  Ox::AltBuilder.build(&block).to_s(options)
end
