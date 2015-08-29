require 'spec_helper'

describe StyleStats::Css::Selector do
  describe '#identifier_count' do
    it { expect(StyleStats::Css::Selector.new('.foo  .bar > .baz + .qux ~ .quux:before').identifier_count).to eq(5) }
    it { expect(StyleStats::Css::Selector.new('.foo').identifier_count).to eq(1) }
  end
end
