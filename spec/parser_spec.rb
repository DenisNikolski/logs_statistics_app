# frozen_string_literal: true

require 'parser'
require 'page_views'

describe Parser do
  describe '#parse' do
    subject { Parser.new.parse(file) }
    let(:pages_views) { [] }

    context 'parse file with all data' do
      let(:file) { 'spec/fixtures/files/webserver_small.log' }

      before do
        pages_views << PageViews.new('/about', 4, 2)
        pages_views << PageViews.new('/home', 3, 3)
        pages_views << PageViews.new('/help_page/1', 2, 1)
      end

      it { is_expected.to eq(pages_views) }
    end

    context 'parse file with missing IP' do
      let(:file) { 'spec/fixtures/files/webserver_with_missing_ip.log' }

      before do
        pages_views << PageViews.new('/about', 3, 2)
        pages_views << PageViews.new('/home', 2, 2)
        pages_views << PageViews.new('/help_page/1', 2, 1)
      end

      it { is_expected.to eq(pages_views) }
    end

    context 'parse file with missing page' do
      let(:file) { 'spec/fixtures/files/webserver_with_missing_page.log' }

      before do
        pages_views << PageViews.new('/about', 3, 2)
        pages_views << PageViews.new('/home', 2, 2)
        pages_views << PageViews.new('/help_page/1', 2, 1)
      end

      it { is_expected.to eq(pages_views) }
    end
  end
end
