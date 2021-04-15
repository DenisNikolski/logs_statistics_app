# frozen_string_literal: true

require_relative '../bin/logs_statistics'

describe 'logs statistics' do
  describe '#call' do
    subject { LogsStatistics.new(path).call }

    let(:views_statistics_msg) do
      'list of webpages with most page views ordered from most pages views to less page views'
    end
    let(:uniq_views_statistics_msg) { 'list of webpages with most unique page views also ordered' }

    context 'when show correct log file statistics' do
      let(:path) { 'spec/fixtures/files/webserver_small.log' }
      let(:all_ordered_page_views) { "/about 4 visits\n/home 3 visits\n/help_page/1 2 visits" }
      let(:uniq_ordered_page_views) { "/home 3 unique views\n/about 2 unique views\n/help_page/1 1 unique views" }

      it { expect { subject }.to output(a_string_including(views_statistics_msg)).to_stdout }
      it { expect { subject }.to output(a_string_including(uniq_views_statistics_msg)).to_stdout }
      it { expect { subject }.to output(a_string_including(all_ordered_page_views)).to_stdout }
      it { expect { subject }.to output(a_string_including(uniq_ordered_page_views)).to_stdout }
    end

    context 'when show log file contains wrong data' do
      let(:path) { 'spec/fixtures/files/webserver_with_wrong_data.log' }
      let(:all_ordered_page_views) { "/about 2 visits\n/help_page/1 2 visits\n/home 1 visits" }
      let(:uniq_ordered_page_views) { "/about 2 unique views\n/home 1 unique views\n/help_page/1 1 unique views" }
      let(:wrong_ip_warning) { 'warning: IP address 444.701.448.104 on line 5 is wrong' }
      let(:wring_page_warning) { 'warning: page 123123 on line 6 is wrong' }

      it { expect { subject }.to output(a_string_including(views_statistics_msg)).to_stdout }
      it { expect { subject }.to output(a_string_including(uniq_views_statistics_msg)).to_stdout }
      it { expect { subject }.to output(a_string_including(all_ordered_page_views)).to_stdout }
      it { expect { subject }.to output(a_string_including(uniq_ordered_page_views)).to_stdout }
      it { expect { subject }.to output(a_string_including(wrong_ip_warning)).to_stdout }
      it { expect { subject }.to output(a_string_including(wring_page_warning)).to_stdout }
    end

    context 'when not all info in the file' do
      let(:warning_msg) { 'warning: Record does not have all needed info(line#' }

      context 'when file with missing ip' do
        let(:path) { 'spec/fixtures/files/webserver_with_missing_ip.log' }
        let(:all_ordered_page_views) { "/about 3 visits\n/home 2 visits\n/help_page/1 2 visits" }
        let(:uniq_ordered_page_views) { "/about 2 unique views\n/home 2 unique views\n/help_page/1 1 unique views" }

        it { expect { subject }.to output(a_string_including(warning_msg)).to_stdout }
        it { expect { subject }.to output(a_string_including(views_statistics_msg)).to_stdout }
        it { expect { subject }.to output(a_string_including(uniq_views_statistics_msg)).to_stdout }
        it { expect { subject }.to output(a_string_including(all_ordered_page_views)).to_stdout }
        it { expect { subject }.to output(a_string_including(uniq_ordered_page_views)).to_stdout }
      end

      context 'when file with missing page' do
        let(:path) { 'spec/fixtures/files/webserver_with_missing_page.log' }
        let(:all_ordered_page_views) { "/about 3 visits\n/home 2 visits\n/help_page/1 2 visits" }
        let(:uniq_ordered_page_views) { "/about 2 unique views\n/home 2 unique views\n/help_page/1 1 unique views" }

        it { expect { subject }.to output(a_string_including(warning_msg)).to_stdout }
        it { expect { subject }.to output(a_string_including(views_statistics_msg)).to_stdout }
        it { expect { subject }.to output(a_string_including(uniq_views_statistics_msg)).to_stdout }
        it { expect { subject }.to output(a_string_including(all_ordered_page_views)).to_stdout }
        it { expect { subject }.to output(a_string_including(uniq_ordered_page_views)).to_stdout }
      end
    end

    context 'when no file path is passed' do
      let(:path) {}

      it { expect { subject }.to output(a_string_including('Please specify file path')).to_stdout }
    end

    context 'when file path is empty' do
      let(:path) { '' }

      it { expect { subject }.to output(a_string_including('Please specify file path')).to_stdout }
    end

    context 'when file does not exists' do
      let(:path) { 'file_that_does_not_exists.log' }

      it { expect { subject }.to output(a_string_including('File does not exists')).to_stdout }
    end

    context 'when wrong file extension' do
      let(:path) { 'spec/fixtures/files/webserver.jpg' }

      it { expect { subject }.to output(a_string_including('File have wrong extension')).to_stdout }
    end

    context 'when file is empty' do
      let(:path) { 'spec/fixtures/files/empty_webserver.log' }

      it { expect { subject }.to output(a_string_including('File is empty')).to_stdout }
    end
  end
end
