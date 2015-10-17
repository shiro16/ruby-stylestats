require 'spec_helper'

describe StyleStats::Template do
  let(:css) { StyleStats::Css.new(spec_css_path) }

  describe '#initialize' do
    it 'set instance of StyleStats::Css to @css' do
      expect(StyleStats::Template.new(css).instance_variable_get(:@css)).to eq(css)
    end

    context 'when not set options argument' do
      it { expect(StyleStats::Template.new(css).instance_variable_get(:@options)).to eq({format: :default}) }
    end

    context 'when set format option' do
      let(:options) { {format: :json} }
      it { expect(StyleStats::Template.new(css, options).instance_variable_get(:@options)).to eq(options) }
    end

    context 'when set template option' do
      let(:options) { {template: fixtures_path_for('spec.erb')} }
      it { expect(StyleStats::Template.new(css, options).instance_variable_get(:@options)).to eq(options.merge(format: :template)) }
    end
  end
end
