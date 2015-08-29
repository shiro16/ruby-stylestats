require 'spec_helper'

describe StyleStats::Css::AggregateDeclaration do
  describe '#add' do
    let(:aggregate_declaration) { StyleStats::Css::AggregateDeclaration.new }

    before do
      aggregate_declaration.add('property', 'value')
    end

    it { expect(aggregate_declaration['property']).to eq({values: ['value'], count: 1}) }
    it do
      aggregate_declaration.add('property', 'value')
      expect(aggregate_declaration['property']).to eq({values: ['value'], count: 2})
    end
  end
end
