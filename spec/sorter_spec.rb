# frozen_string_literal: true

require 'sorter'
require 'page_views'

describe Sorter do
  describe '#call' do
    subject { Sorter.new(pages_views).call(criteria) }
    let(:pages_views) do
      [PageViews.new('/home', 3, 3),
       PageViews.new('/help_page/1', 2, 1),
       PageViews.new('/about', 4, 2)]
    end

    context 'when sort criteria is views' do
      let(:criteria) { :views }
      let(:pages_sorted_by_all_views) do
        [PageViews.new('/about', 4, 2),
         PageViews.new('/home', 3, 3),
         PageViews.new('/help_page/1', 2, 1)]
      end

      it { is_expected.to eq(pages_sorted_by_all_views) }
    end

    context 'when sort criteria is uniq views' do
      let(:criteria) { :uniq_views }
      let(:pages_sorted_by_uniq_views) do
        [PageViews.new('/home', 3, 3),
         PageViews.new('/about', 4, 2),
         PageViews.new('/help_page/1', 2, 1)]
      end

      it { is_expected.to eq(pages_sorted_by_uniq_views) }
    end
  end
end
