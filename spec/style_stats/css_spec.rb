require 'spec_helper'

describe StyleStats::Css do
  describe '#initialize' do
    it 'set default value' do
      css = StyleStats::Css.new

      expect(css.path).to eq(nil)
      expect(css.paths).to eq([])
      expect(css.rules).to eq([])
      expect(css.media_types).to eq([])
      expect(css.selectors).to eq([])
      expect(css.stylesheets).to eq([])
      expect(css.elements).to eq([])
    end

    context 'when set path argument' do
      let(:css) { StyleStats::Css.new(spec_css_path) }

      it { expect(css.path).to eq(spec_css_path) }

      it { expect(css.paths).to eq([spec_css_path]) }

      it do
        expect_any_instance_of(StyleStats::Css).to receive(:parse)
        css
      end
    end
  end

  describe '#merge' do
    let(:csses) { [StyleStats::Css.new(spec_css_path), StyleStats::Css.new(spec_css_path)] }

    it do
      expect(csses.first).to receive(:dup).and_return(csses.first)
      expect(csses.first).to receive(:merge!).with(csses.last)
      csses.first.merge(csses.last)
    end
  end

  describe '#merge!' do
    let!(:csses) { [StyleStats::Css.new(spec_css_path), StyleStats::Css.new(spec_css_path)] }

    it do
      expect_any_instance_of(StyleStats::Css).to receive(:clear_aggregate)
      csses.first.merge(csses.last)
    end

    it do
      css = csses.first
      css.merge!(csses.last)
      expect(css.paths.count).to eq(csses.last.paths.count * 2)
      expect(css.rules.count).to eq(csses.last.rules.count * 2)
      expect(css.media_types.count).to eq(csses.last.media_types.count * 2)
      expect(css.selectors.count).to eq(csses.last.selectors.count * 2)
      expect(css.stylesheets.count).to eq(csses.last.stylesheets.count * 2)
      expect(css.elements.count).to eq(csses.last.elements.count * 2)
    end
  end

  describe '#data_uri_size' do
    let(:css) { StyleStats::Css.new(spec_css_path) }

    it { expect(css.data_uri_size).to eq(82) }
  end

  describe '#size' do
    let(:css) { StyleStats::Css.new(spec_css_path) }

    it { expect(css.size).to eq(776) }
  end

  describe '#gzipped_size' do
    let(:css) { StyleStats::Css.new(spec_css_path) }

    it { expect(css.gzipped_size).to eq(433) }
  end

  describe '#selectors_count' do
    let(:css) { StyleStats::Css.new(spec_css_path) }

    it('type is nil') { expect(css.selectors_count).to eq(15) }
    it('type is :id') { expect(css.selectors_count(:id)).to eq(1) }
    it('type is :universal') { expect(css.selectors_count(:universal)).to eq(1) }
    it('type is :unqualified') { expect(css.selectors_count(:unqualified)).to eq(1) }
    context 'when type is :js' do
      it 'set javascriptSpecificSelectors' do
        StyleStats.configuration.options[:javascriptSpecificSelectors] = StyleStats::Configuration.new.options[:javascriptSpecificSelectors]
        expect(css.selectors_count(:js)).to eq(1)
      end

      it 'not set javascriptSpecificSelectors' do
        StyleStats.configuration.options[:javascriptSpecificSelectors] = false
        expect(css.selectors_count(:js)).to eq(0)
      end
    end

    context 'when type is :user' do
      it 'set userSpecifiedSelectors' do
        StyleStats.configuration.options[:userSpecifiedSelectors] = 'foo'
        expect(css.selectors_count(:user)).to eq(3)
      end

      it 'not set userSpecifiedSelectors' do
        StyleStats.configuration.options[:userSpecifiedSelectors] = false
        expect(css.selectors_count(:user)).to eq(0)
      end
    end
  end

  describe '#declarations_count' do
    let(:css) { StyleStats::Css.new(spec_css_path) }

    it('type is nil') { expect(css.declarations_count).to eq(39) }
    it('type is :important') { expect(css.declarations_count(:important)).to eq(1) }
    it('type is :float') { expect(css.declarations_count(:float)).to eq(1) }
  end

  describe '#[]' do
    let(:css) { StyleStats::Css.new(spec_css_path) }

    it { expect(css["font-family"]).to be_a(Hash) }
  end

  describe '#clear_aggregate' do
    let(:css) { StyleStats::Css.new(spec_css_path) }

    it do
      css.instance_variable_set(:@aggregate_declaration, true)
      css.clear_aggregate
      expect(css.instance_variable_get(:@aggregate_declaration)).to be_nil
    end
  end

  describe '#declarations' do
    let(:css) { StyleStats::Css.new(spec_css_path) }

    it { expect(css.declarations).to eq(css.selectors.map(&:declarations).flatten) }
  end

  describe 'private methods' do
    describe '#parse' do
      let(:css) { StyleStats::Css.new(nil) }
      let(:fetch) { StyleStats::Css::Fetch.new(spec_css_path) }

      before do
        css.path = spec_css_path
      end

      it do
        expect(StyleStats::Css::Fetch).to receive(:new).with(css.path).and_return(fetch)
        expect(css).to receive(:merge_css_parser).exactly(1).times
        css.send(:parse)
      end
    end

    describe '#create_css_parser' do
      let(:css) { StyleStats::Css.new }
      let(:style) { 'font { color: #FFFFFF }' }

      it do
        expect_any_instance_of(CssParser::Parser).to receive(:add_block!).with(style)
        expect(css.send(:create_css_parser, style)).to be_a(CssParser::Parser)
      end
    end

    describe '#merge_css_parser' do
      let(:css) { StyleStats::Css.new }
      let(:style) { 'font { color: #FFFFFF }' }
      let(:parser) { CssParser::Parser.new }

      before do
        parser.add_block!(style)
      end

      it do
        expect(StyleStats::Css::Declaration).to receive(:new)
        expect(StyleStats::Css::Selector).to receive(:new)
        expect(css).to receive(:clear_aggregate)
        css.send(:merge_css_parser, parser)
        expect(css.rules).not_to eq(0)
        expect(css.selectors.count).not_to eq(0)
        expect(css.media_types.include?(:all)).to be_falsey
      end
    end

    describe '#aggregate' do
      let(:css) { StyleStats::Css.new(spec_css_path) }

      it { expect(css.send(:aggregate)).to be_a(StyleStats::Css::AggregateDeclaration) }
    end
  end
end
