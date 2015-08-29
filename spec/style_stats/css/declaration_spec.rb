require 'spec_helper'

describe StyleStats::Css::Declaration do
  describe '#initialize' do
    context 'when value have important' do
      let(:declaration) { StyleStats::Css::Declaration.new('property', 'value !important') }

      it { expect(declaration.important).to be_truthy }
      it { expect(declaration.value).to eq('value') }
    end

    context 'when value have not important' do
      let(:declaration) { StyleStats::Css::Declaration.new('property', 'value') }

      it { expect(declaration.important).to be_falsy }
      it { expect(declaration.value).to eq('value') }
    end
  end
end
