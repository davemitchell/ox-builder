require 'spec_helper'

describe Tilt::OxAltBuilderTemplate do
  it 'should add the ox template handler' do
    expect(Tilt.mappings['ox']).to eq([described_class])
  end

  it 'should allow ActionView to render Ox::AltBuilder templates' do
    t = Tilt.new('spec/support/test.ox')
    expect(t.render).to eq(load_xml(:test))
  end
end
