require 'spec_helper'

describe StyleStats::Css::Fetch do
  let(:fetch) { StyleStats::Css::Fetch.new(spec_css_path, options) }
  let(:options) { { user_agent: 'test' } }

  describe '#initialize' do
    it 'call get method' do
      expect_any_instance_of(StyleStats::Css::Fetch).to receive(:get).with(spec_css_path)
      expect(fetch.instance_variable_get(:@options)).to eq(options)
    end
  end

  describe 'private methods' do
    let(:doc) { Oga.parse_html(open(fixtures_path_for('spec.html')).read) }
    let(:uri) { 'http://example.com/' }

    describe '#get' do
      context 'when path is uri string' do
        it do
          expect(fetch).to receive(:request).with(uri)
          fetch.send(:get, uri)
        end
      end

      context 'when path is other string' do
        it do
          fetch.send(:get, spec_css_path)
          expect(fetch.stylesheets.count).to eq(2)
        end
      end
    end

    describe '#request' do
      before do
        allow_any_instance_of(File).to receive(:content_type).and_return(content_type)
      end

      context 'when content type css' do
        let(:content_type) { 'text/css' }

        before do
          fetch.send(:request, spec_css_path)
        end

        it { expect(fetch.stylesheets.count).to eq(2) }
      end

      context 'when content type html' do
        let(:content_type) { 'text/html' }

        before do
          expect(fetch).to receive(:find_stylesheets).and_return([])
          expect(fetch).to receive(:find_elements).and_return([])
          fetch.send(:request, fixtures_path_for('spec.html'))
        end

        it { expect(fetch.stylesheets.count).to eq(1) }
        it { expect(fetch.elements.count).to eq(0) }
      end

      context 'when content type other' do
        let(:content_type) { 'text' }

        it { expect{ fetch.send(:request, fixtures_path_for('spec.txt'))}.to raise_error(StyleStats::ContentError) }
      end
    end

    describe '#find_elements' do
      it { expect(fetch.send(:find_elements, doc).count).to eq(1) }
    end

    describe '#find_stylesheets' do
      it { expect(fetch.send(:find_stylesheets, doc, uri).count).to eq(1) }
      it { expect(fetch.send(:find_stylesheets, doc, uri)).to eq(["http://example.com/spec.css"]) }
    end
  end
end
