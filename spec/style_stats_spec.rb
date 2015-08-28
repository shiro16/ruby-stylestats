require 'spec_helper'

describe StyleStats do
  describe '.initialize' do
    it 'set @options' do

    end

    it 'call PathParser.new' do

    end

    it 'call Css.new' do

    end

    it 'set @css' do

    end
  end

  describe '#render' do
    let(:style_stats) { StyleStats.new() }

    it 'call Template#render' do
    end
  end

  it 'has a version number' do
    expect(StyleStats::VERSION).not_to be nil
  end
end
