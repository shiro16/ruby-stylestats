require 'spec_helper'

describe StyleStats::PathParser do
  let(:path_parser) { StyleStats::PathParser.new(spec_css_path) }

  describe '#initialize' do
    it 'call parse method with path' do
      expect_any_instance_of(StyleStats::PathParser).to receive(:parse).with(spec_css_path)
      path_parser
    end
  end

  describe 'private methods' do
    describe '#parse' do
      context 'when path is URI string' do
        let(:uri) { 'http://example.com/' }
        it { expect(path_parser.send(:parse, uri)).to eq [uri] }
      end

      context 'when path is file path' do
        it 'when css file' do
          expect(path_parser.send(:parse, spec_css_path)).to eq [spec_css_path]
        end

        it 'when invalid extensions raise InvalidError' do
          expect{path_parser.send(:parse, fixtures_path_for('spec.txt'))}.to raise_error(StyleStats::InvalidError)
        end
      end

      context 'when other string' do
        let(:path) { './*.css' }

        it 'call #fetch_files method and #filter_extention method' do
          expect(path_parser).to receive(:fetch_files).with(path).and_return([path])
          expect(path_parser).to receive(:filter_extention).with([path])
          path_parser.send(:parse, path)
        end
      end
    end

    describe '#fetch_files' do
      context 'when path is directory' do
        it do
          expect(Dir).to receive(:entries).with(fixtures_path_for).and_return([])
          path_parser.send(:fetch_files, fixtures_path_for)
        end

        it {
          expect(path_parser.send(:fetch_files, fixtures_path_for)).to eq([
            fixtures_path_for('.'),
            fixtures_path_for('..'),
            fixtures_path_for('spec.css'),
            fixtures_path_for('spec.erb'),
            fixtures_path_for('spec.html'),
            fixtures_path_for('spec.txt'),
            fixtures_path_for('style_stats.json'),
            fixtures_path_for('style_stats.yml')
          ])
        }
      end

      context 'when path is not directory' do
        it { expect(path_parser.send(:fetch_files, fixtures_path_for('*.css'))).to eq([spec_css_path]) }
      end
    end

    describe '#filter_extention' do
      it {
        expect(path_parser.send(:filter_extention, ['1.less', '2.styl', '3.stylus', '4.css', '5.txt'])).to eq(
          ['1.less', '2.styl', '3.stylus', '4.css']
        )
      }
    end
  end
end
