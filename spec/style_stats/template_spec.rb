require 'spec_helper'

describe StyleStats::Template do
  let(:css) { StyleStats::Css.new(spec_css_path) }

  describe '#initialize' do
    let(:options) { {format: :json} }

    it 'set instance of StyleStats::Css to @css' do
      expect(StyleStats::Template.new(css).instance_variable_get(:@css)).to eq(css)
    end

    context 'when not set options argument' do
      it { expect(StyleStats::Template.new(css).instance_variable_get(:@options)).to eq({format: :default}) }
    end

    context 'when set options' do
      it { expect(StyleStats::Template.new(css, options).instance_variable_get(:@options)).to eq(options) }
    end
  end
end
