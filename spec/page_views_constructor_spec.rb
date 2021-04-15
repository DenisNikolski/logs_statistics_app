# frozen_string_literal: true

require 'page_views_constructor'
require 'page_views'

describe PageViewsConstructor do
  describe '#call' do
    subject { PageViewsConstructor.new(pages_visitors_ips).call }

    context 'when page visitors ips is passed' do
      let(:pages_visitors_ips) do
        { '/about' => %w[1.1.2.1 1.1.2.1 1.1.1.1],
          '/home' => %w[1.1.1.1 1.1.1.2 1.1.2.1] }
      end
      let(:pages_views) do
        [PageViews.new('/about', 3, 2),
         PageViews.new('/home', 3, 3)]
      end

      it { is_expected.to eq(pages_views) }
    end

    context 'when page visitors ips is empty' do
      let(:pages_visitors_ips) { {} }

      it { is_expected.to eq([]) }
    end
  end
end
