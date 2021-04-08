# frozen_string_literal: true

require 'sorter'
require 'page_views'

describe Sorter do
  describe '#sort' do
    subject { Sorter.new.sort(pages_views, criteria) }
    let(:pages_views) { [] }

    before do
      pages_views << PageViews.new('/home', 3, 3)
      pages_views << PageViews.new('/help_page/1', 2, 1)
      pages_views << PageViews.new('/about', 4, 2)
    end

    context 'sort by all views' do
      let(:pages_sorted_by_all_views) { [] }
      let(:criteria) { :views }

      before do
        pages_sorted_by_all_views << PageViews.new('/about', 4, 2)
        pages_sorted_by_all_views << PageViews.new('/home', 3, 3)
        pages_sorted_by_all_views << PageViews.new('/help_page/1', 2, 1)
      end

      it { is_expected.to eq(pages_sorted_by_all_views) }
    end

    context 'sort by uniq views' do
      let(:pages_sorted_by_uniq_views) { [] }
      let(:criteria) { :uniq_views }

      before do
        pages_sorted_by_uniq_views << PageViews.new('/home', 3, 3)
        pages_sorted_by_uniq_views << PageViews.new('/about', 4, 2)
        pages_sorted_by_uniq_views << PageViews.new('/help_page/1', 2, 1)
      end

      it { is_expected.to eq(pages_sorted_by_uniq_views) }
    end
  end
end
