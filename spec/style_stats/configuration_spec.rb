require 'spec_helper'

describe StyleStats::Configuration do
  context "default instance variable" do
    let(:options) { StyleStats::Configuration.new.options }

    it { expect(options[:published]).to be_truthy }
    it { expect(options[:stylesheets]).to be_truthy }
    it { expect(options[:paths]).to be_truthy }
    it { expect(options[:stylesheets]).to be_truthy }
    it { expect(options[:styleElements]).to be_truthy }
    it { expect(options[:size]).to be_truthy }
    it { expect(options[:dataUriSize]).to be_truthy }
    it { expect(options[:ratioOfDataUriSize]).to be_truthy }
    it { expect(options[:gzippedSize]).to be_truthy }
    it { expect(options[:rules]).to be_truthy }
    it { expect(options[:selectors]).to be_truthy }
    it { expect(options[:declarations]).to be_truthy }
    it { expect(options[:simplicity]).to be_truthy }
    it { expect(options[:averageOfIdentifier]).to be_truthy }
    it { expect(options[:mostIdentifier]).to be_truthy }
    it { expect(options[:mostIdentifierSelector]).to be_truthy }
    it { expect(options[:averageOfCohesion]).to be_truthy }
    it { expect(options[:lowestCohesion]).to be_truthy }
    it { expect(options[:lowestCohesionSelector]).to be_truthy }
    it { expect(options[:totalUniqueFontSizes]).to be_truthy }
    it { expect(options[:uniqueFontSizes]).to be_truthy }
    it { expect(options[:totalUniqueFontFamilies]).to be_truthy }
    it { expect(options[:uniqueFontFamilies]).to be_truthy }
    it { expect(options[:totalUniqueColors]).to be_truthy }
    it { expect(options[:uniqueColors]).to be_truthy }
    it { expect(options[:idSelectors]).to be_truthy }
    it { expect(options[:universalSelectors]).to be_truthy }
    it { expect(options[:unqualifiedAttributeSelectors]).to be_truthy }
    it { expect(options[:javascriptSpecificSelectors]).to eq("[#\\.]js\\-") }
    it { expect(options[:userSpecifiedSelectors]).to be_falsey }
    it { expect(options[:importantKeywords]).to be_truthy }
    it { expect(options[:floatProperties]).to be_truthy }
    it { expect(options[:propertiesCount]).to eq(10) }
    it { expect(options[:mediaQueries]).to be_truthy }
    it { expect(options[:requestOptions]).to eq({ headers: {} }) }
  end
end
