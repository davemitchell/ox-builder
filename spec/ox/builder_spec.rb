require 'spec_helper'

Shape = Struct.new(:type, :width, :height, :color)

describe Ox::Builder do
  it 'should build a simple document' do
    doc = generate do
      instruct!
      tag! :name, cdata!('John'), for: 'creator'
      tag! :data do
        tag! :foo, :bar
      end
    end

    expect(doc).to eq(load_xml(:simple))
  end

  it 'should build a simple document using a block param' do
    doc = generate do |xml|
      xml.instruct!
      xml.tag! :name, xml.cdata!('John'), for: 'creator'
      xml.tag! :data do |xml|
        xml.tag! :foo, :bar
      end
    end

    expect(doc).to eq(load_xml(:simple))
  end

  it 'should build a complex document' do
    @shapes = [ Shape.new(:rectangle, 30, 15), Shape.new(:square, 20, 20, '#CCCCCC') ]

    doc = generate do |xml|
      xml.instruct!
      xml.data do |xml|
        xml.provider xml.cdata!('Data-Provider')
        xml.provided_at Date.new(2016, 4, 10).strftime('%a, %e %b %Y %H:%M:%S GMT')

        xml.shapes do |xml|
          @shapes.each do |shape|
            xml.shape do |xml|
              xml.type xml.cdata!(shape.type)
              xml.width shape.width
              xml.height shape.height
              xml.color xml.cdata!(shape.color)
            end
          end
        end
      end
    end

    expect(doc).to eq(load_xml(:complex))
  end

  it 'should build a complex document without block params' do
    shapes = [ Shape.new(:rectangle, 30, 15), Shape.new(:square, 20, 20, '#CCCCCC') ]

    doc = generate do
      instruct!
      data do
        provider cdata!('Data-Provider')
        provided_at Date.new(2016, 4, 10).strftime('%a, %e %b %Y %H:%M:%S GMT')

        shapes do
          shapes.each do |s|
            shape do
              type cdata!(s.type)
              width s.width
              height s.height
              color cdata!(s.color)
            end
          end
        end
      end
    end

    expect(doc).to eq(load_xml(:complex))
  end

  it 'should build nested XML using tag!' do
    doc = generate do
      tag! :person do
        tag! :first_name, 'John'
        tag! :last_name, 'Smith'

        tag! :address do
          tag! :country, 'Canada'
          tag! :state, 'Ontario'
        end
      end
    end

    expect(doc).to eq(load_xml('person'))
  end
end
