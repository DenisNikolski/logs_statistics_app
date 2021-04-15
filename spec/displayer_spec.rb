# frozen_string_literal: true

require 'displayer'
require 'page_views'

describe Displayer do
  describe '#call' do
    subject { Displayer.call(page_views, counter_key, messages) }
    let(:messages) { { header_msg: 'header msg', item_msg: 'visits' } }
    let(:page_views) do
      [PageViews.new('/about', 4, 2),
       PageViews.new('/home', 3, 3),
       PageViews.new('/help_page/1', 2, 1)]
    end

    context 'when display by all views' do
      let(:counter_key) { :views }
      let(:all_ordered_page_views) { "/about 4 visits\n/home 3 visits\n/help_page/1 2 visits" }

      it { expect { subject }.to output(a_string_including(messages[:header_msg])).to_stdout }
      it { expect { subject }.to output(a_string_including(all_ordered_page_views)).to_stdout }
    end

    context 'when display by uniq views' do
      let(:counter_key) { :uniq_views }
      let(:uniq_ordered_page_views) { "/about 2 visits\n/home 3 visits\n/help_page/1 1 visits" }

      it { expect { subject }.to output(a_string_including(messages[:header_msg])).to_stdout }
      it { expect { subject }.to output(a_string_including(uniq_ordered_page_views)).to_stdout }
    end
  end
end
