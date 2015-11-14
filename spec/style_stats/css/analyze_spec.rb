require 'spec_helper'

describe StyleStats::Css do
  let(:css) { StyleStats::Css.new(spec_css_path) }

  describe '#analyze' do
    it do
      expect(css).to receive(:analyze_published)
      expect(css).to receive(:analyze_paths)
      expect(css).to receive(:analyze_stylesheets)
      expect(css).to receive(:analyze_style_elements)
      expect(css).to receive(:analyze_size)
      expect(css).to receive(:analyze_data_uri_size)
      expect(css).to receive(:analyze_ratio_of_data_uri_size)
      expect(css).to receive(:analyze_gzipped_size)
      expect(css).to receive(:analyze_rules)
      expect(css).to receive(:analyze_selectors)
      expect(css).to receive(:analyze_declarations)
      expect(css).to receive(:analyze_simplicity)
      expect(css).to receive(:analyze_average_of_identifier)
      expect(css).to receive(:analyze_most_identifier)
      expect(css).to receive(:analyze_most_identifier_selector)
      expect(css).to receive(:analyze_average_of_cohesion)
      expect(css).to receive(:analyze_lowest_cohesion)
      expect(css).to receive(:analyze_lowest_cohesion_selector)
      expect(css).to receive(:analyze_total_unique_font_sizes)
      expect(css).to receive(:analyze_unique_font_sizes)
      expect(css).to receive(:analyze_total_unique_font_families)
      expect(css).to receive(:analyze_unique_font_families)
      expect(css).to receive(:analyze_total_unique_colors)
      expect(css).to receive(:analyze_unique_colors)
      expect(css).to receive(:analyze_id_selectors)
      expect(css).to receive(:analyze_universal_selectors)
      expect(css).to receive(:analyze_unqualified_attribute_selectors)
      expect(css).to receive(:analyze_javascript_specific_selectors)
      expect(css).to receive(:analyze_user_specific_selectors)
      expect(css).to receive(:analyze_important_keywords)
      expect(css).to receive(:analyze_fload_properties)
      expect(css).to receive(:analyze_properties_count)
      expect(css).to receive(:analyze_media_queries)
      expect(css.analyze).to be_a(Hash)
    end
  end

  describe '#analyze_published' do
    let(:key) { 'Published' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:published] = option
      css.instance_variable_set(:@result, {})
      css.send(:analyze_published)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to be_a(Time) }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end

  describe '#analyze_paths' do
    let(:key) { 'Paths' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:paths] = option
      css.instance_variable_set(:@result, {})
      css.send(:analyze_paths)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to eq(["spec/fixtures/spec.css"]) }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end

  describe '#analyze_stylesheets' do
    let(:key) { 'Style Elements' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:stylesheets] = option
      css.instance_variable_set(:@result, {})
      css.send(:analyze_stylesheets)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to be_nil }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end

  describe '#analyze_style_elements' do
    let(:key) { 'Style Elements' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:styleElements] = option
      css.instance_variable_set(:@result, {})
      css.send(:analyze_style_elements)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to eq(0) }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end

  describe '#analyze_size' do
    let(:key) { 'Size' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:size] = option
      css.instance_variable_set(:@result, {})
      css.send(:analyze_size)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to eq(776) }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end

  describe '#analyze_data_uri_size' do
    let(:key) { 'Data URI Size' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:dataUriSize] = option
      css.instance_variable_set(:@result, {})
      css.send(:analyze_data_uri_size)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to eq(82) }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end

  describe '#analyze_ratio_of_data_uri_size' do
    let(:key) { 'Ratio of Data URI Size' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:ratioOfDataUriSize] = option
      css.instance_variable_set(:@result, {})
      css.send(:analyze_ratio_of_data_uri_size)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to eq('10.0%') }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end

  describe '#analyze_gzipped_size' do
    let(:key) { 'Gzipped Size' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:gzippedSize] = option
      css.instance_variable_set(:@result, {})
      css.send(:analyze_gzipped_size)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to eq(433) }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end

  describe '#analyze_rules' do
    let(:key) { 'Rules' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:rules] = option
      css.instance_variable_set(:@result, {})
      css.send(:analyze_rules)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to eq(10) }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end

  describe '#analyze_selectors' do
    let(:key) { 'Selectors' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:selectors] = option
      css.instance_variable_set(:@result, {})
      css.send(:analyze_selectors)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to eq(15) }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end

  describe '#analyze_declarations' do
    let(:key) { 'Declarations' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:declarations] = option
      css.instance_variable_set(:@result, {})
      css.send(:analyze_declarations)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to eq(39) }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end

  describe '#analyze_simplicity' do
    let(:key) { 'Simplicity' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:simplicity] = option
      css.instance_variable_set(:@result, {})
      css.send(:analyze_simplicity)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to eq('70.0%') }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end

  describe '#analyze_average_of_identifier' do
    let(:key) { 'Average of Identifier' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:averageOfIdentifier] = option
      css.instance_variable_set(:@result, {})
      css.send(:analyze_average_of_identifier)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to eq(1.467) }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end

  describe '#analyze_most_identifier' do
    let(:key) { 'Most Identifier' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:mostIdentifier] = option
      css.instance_variable_set(:@most_indentifier_selector, StyleStats::Css::Selector.new(""))
      css.instance_variable_set(:@result, {})
      css.send(:analyze_most_identifier)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to eq(0) }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end

  describe '#analyze_most_identifier_selector' do
    let(:key) { 'Most Identifier Selector' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:mostIdentifierSelector] = option
      css.instance_variable_set(:@most_indentifier_selector, StyleStats::Css::Selector.new("test"))
      css.instance_variable_set(:@result, {})
      css.send(:analyze_most_identifier_selector)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to eq("test") }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end

  describe '#analyze_average_of_cohesion' do
    let(:key) { 'Average of Cohesion' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:averageOfCohesion] = option
      css.instance_variable_set(:@result, {})
      css.send(:analyze_average_of_cohesion)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to eq(3.9) }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end

  describe '#analyze_lowest_cohesion' do
    let(:key) { 'Lowest Cohesion' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:lowestCohesion] = option
      css.instance_variable_set(:@selector, StyleStats::Css::Selector.new("test"))
      css.instance_variable_set(:@result, {})
      css.send(:analyze_lowest_cohesion)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to eq(0) }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end

  describe '#analyze_lowest_cohesion_selector' do
    let(:key) { 'Lowest Cohesion Selector' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:lowestCohesionSelector] = option
      css.instance_variable_set(:@selector, StyleStats::Css::Selector.new("test"))
      css.instance_variable_set(:@result, {})
      css.send(:analyze_lowest_cohesion_selector)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to eq("test") }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end

  describe '#analyze_total_unique_font_sizes' do
    let(:key) { 'Total Unique Font Sizes' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:totalUniqueFontSizes] = option
      css.instance_variable_set(:@result, {})
      css.send(:analyze_total_unique_font_sizes)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to eq(5) }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end

  describe '#analyze_unique_font_sizes' do
    let(:key) { 'Unique Font Sizes' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:uniqueFontSizes] = option
      css.instance_variable_set(:@result, {})
      css.send(:analyze_unique_font_sizes)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to match_array(["12px", "16px", "10px", "18px", "14px"]) }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end

  describe '#analyze_total_unique_font_families' do
    let(:key) { 'Total Unique Font Families' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:totalUniqueFontFamilies] = option
      css.instance_variable_set(:@result, {})
      css.send(:analyze_total_unique_font_families)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to eq(1) }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end

  describe '#analyze_unique_font_families' do
    let(:key) { 'Unique Font Families' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:uniqueFontFamilies] = option
      css.instance_variable_set(:@result, {})
      css.send(:analyze_unique_font_families)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to eq(["Impact"]) }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end

  describe '#analyze_total_unique_colors' do
    let(:key) { 'Total Unique Colors' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:totalUniqueColors] = option
      css.instance_variable_set(:@result, {})
      css.send(:analyze_total_unique_colors)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to eq(2) }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end

  describe '#analyze_unique_colors' do
    let(:key) { 'Unique Colors' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:uniqueColors] = option
      css.instance_variable_set(:@result, {})
      css.send(:analyze_unique_colors)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to eq(["#ccc", "#333"]) }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end

  describe '#analyze_id_selectors' do
    let(:key) { 'ID Selectors' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:idSelectors] = option
      css.instance_variable_set(:@result, {})
      css.send(:analyze_id_selectors)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to eq(1) }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end

  describe '#analyze_universal_selectors' do
    let(:key) { 'Universal Selectors' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:universalSelectors] = option
      css.instance_variable_set(:@result, {})
      css.send(:analyze_universal_selectors)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to eq(1) }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end

  describe '#analyze_unqualified_attribute_selectors' do
    let(:key) { 'Unqualified Attribute Selectors' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:unqualifiedAttributeSelectors] = option
      css.instance_variable_set(:@result, {})
      css.send(:analyze_unqualified_attribute_selectors)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to eq(1) }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end

  describe '#analyze_javascript_specific_selectors' do
    let(:key) { 'JavaScript Specific Selectors' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:javascriptSpecificSelectors] = option
      css.instance_variable_set(:@result, {})
      css.send(:analyze_javascript_specific_selectors)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to eq(0) }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end

  describe '#analyze_user_specific_selectors' do
    let(:key) { 'User Specific Selectors' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:userSpecificSelectors] = option
      css.instance_variable_set(:@result, {})
      css.send(:analyze_user_specific_selectors)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to eq(0) }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end

  describe '#analyze_important_keywords' do
    let(:key) { 'Important Keywords' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:importantKeywords] = option
      css.instance_variable_set(:@result, {})
      css.send(:analyze_important_keywords)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to eq(1) }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end

  describe '#analyze_fload_properties' do
    let(:key) { 'Float Properties' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:floatProperties] = option
      css.instance_variable_set(:@result, {})
      css.send(:analyze_fload_properties)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to eq(1) }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end

  describe '#analyze_properties_count' do
    let(:key) { 'Properties Count' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:propertiesCount] = option
      css.instance_variable_set(:@result, {})
      css.send(:analyze_properties_count)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to include("font-size: 10", "margin: 9", "padding: 7", "display: 5", "color: 2") }
      it { expect(subject.count).to eq(10) }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end

  describe '#analyze_media_queries' do
    let(:key) { 'Media Queries' }

    subject { css.instance_variable_get(:@result)[key] }

    before do
      StyleStats.configuration.options[:mediaQueries] = option
      css.instance_variable_set(:@result, {})
      css.send(:analyze_media_queries)
    end

    context 'set option true' do
      let(:option) { true }
      it { expect(subject).to eq(1) }
    end

    context 'set option false' do
      let(:option) { false }
      it { expect(subject).to be_nil }
    end
  end
end
